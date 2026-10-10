<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class BlackOps2ZMController extends Controller
{
    public function listenPlayerConnected(Request $request): JsonResponse
    {
        // Validate the incoming requests data
        $validated = $request->validate([
            'guid' => 'required|integer',
            'name' => 'required|string',
        ]);

        // Ensure the user exists
        $user = User::updateOrCreate(
            ['guid' => $validated['guid']],
            ['name' => $validated['name']]
        );

        // Refresh the user model
        $user->refresh();

        // Return the json response data
        return response()->json([
            'success' => true,
            'user' => $user,
            'messages' => config('smoked.lang.listenPlayerConnected.en'),
        ]);
    }

    public function listenEndGame(Request $request): JsonResponse
    {
        // Validate the incoming requests data
        $validated = $request->validate([
            'guid' => 'required|integer',
        ]);

        // Fetch the user
        $user = User::where('guid', $validated['guid'])->first();

        // Update the players data
        $user->kills += $validated["kills"];
        $user->save();

        // Return the json object to be parsed by the server
        return response()->json([
            'success' => true,
            'messages' => config('smoked.lang.listenEndGame.en'),
        ]);
    }

    public function listenPlayerDisconnected(Request $request): JsonResponse
    {
        // Validate the incoming requests data
        $validated = $request->validate([
            'guid' => 'required|integer',
            'kills' => 'required|integer',
        ]);

        // Fetch the user
        $user = User::where('guid', $validated['guid'])->first();

        // Update the players data
        $user->kills += $validated["kills"];
        $user->save();

        // Return the json object to be parsed by the server
        return response()->json(['success' => true]);
    }

    public function commandDeposit(Request $request): JsonResponse
    {
        // Validate the incoming requests data
        $validated = $request->validate([
            'guid' => 'required|integer',
            'args' => 'required',
        ]);

        // Fetch the user
        $user = User::where('guid', $validated['guid'])->first();

        // Return the json object to be parsed by the server
        return response()->json([
            'success' => true,
            'messages' => [config('smoked.lang.commandGodmode.en.enabled')],
        ]);
    }

    public function commandGodmode(Request $request): JsonResponse
    {
        // Validate the incoming requests data
        $validated = $request->validate([
            'guid' => 'required|integer',
            'enabled' => 'required|integer',
        ]);

        // Fetch the user
        $user = User::where('guid', $validated['guid'])->first();

        // Check if the user is not an member of staff
        if ($user->rank < 2) {
            // Return the json object to be parsed by the server
            return response()->json([
                'success' => false,
                'messages' => [config('smoked.lang.commandGodmode.en.denied')],
            ]);
        }

        // Check if godmode is already enabled
        if ($validated["enabled"]) {
            return response()->json([
                'success' => true,
                'messages' => [config('smoked.lang.commandGodmode.en.disabled')],
            ]);
        }

        // Return the json object to be parsed by the server
        return response()->json([
            'success' => true,
            'messages' => [config('smoked.lang.commandGodmode.en.enabled')],
        ]);
    }

    public function commandHelp(Request $request): JsonResponse
    {
        // Return the json object to be parsed by the server
        return response()->json([
            'success' => true,
            'messages' => config('smoked.lang.commandHelp.en.one'),
        ]);
    }

    public function commandWithdraw(Request $request): JsonResponse
    {
        // Validate the incoming requests data
        $validated = $request->validate([
            'guid' => 'required|integer',
            'args' => 'required',
        ]);

        // Fetch the user
        $user = User::where('guid', $validated['guid'])->first();

        // Return the json object to be parsed by the server
        return response()->json([
            'success' => true,
            'messages' => [config('smoked.lang.commandGodmode.en.enabled')],
        ]);
    }
}
