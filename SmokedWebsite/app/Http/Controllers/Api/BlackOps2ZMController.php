<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class BlackOps2ZMController extends Controller
{
    public function user(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'guid' => 'required|integer',
            'name' => 'required|string',
        ]);

        $user = User::updateOrCreate(
            ['guid' => $validated['guid']],
            ['name' => $validated['name']]
        );

        $user->refresh();

        return response()->json([
            'success' => true,
            'user' => $user,
            'messages' => config('smoked.lang.welcome.en'),
        ]);
    }
}
