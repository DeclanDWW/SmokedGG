<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ApiAuthMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  Closure(Request): (Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Validate the incoming request's API key
        if ($request->header('X-Api-Key') !== env('X_API_KEY')) {
            // Return an unauthorized response
            return response()->json([
                'success' => false,
                'message' => 'Invalid API key',
            ], 401);
        }

        return $next($request);
    }
}
