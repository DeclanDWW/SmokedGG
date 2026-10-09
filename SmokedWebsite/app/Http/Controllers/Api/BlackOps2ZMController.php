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
            'messages' => config('smoked.lang.welcome.en'),
        ]);
    }

    public function listenEndGame(Request $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'messages' => config('smoked.lang.welcome.en'),
        ]);
    }

    public function listenPlayerDisconnected(Request $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'messages' => config('smoked.lang.welcome.en'),
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

        // Return the json response data
        return response()->json([
            'success' => true,
            'messages' => config('smoked.lang.welcome.en'),
        ]);
    }

    public function commandHelp(Request $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'messages' => config('smoked.lang.welcome.en'),
        ]);
    }
}
