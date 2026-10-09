<?php

use App\Http\Controllers\Api\BlackOps2ZMController;
use Illuminate\Support\Facades\Route;

Route::middleware('api.auth')->group(function () {
    Route::post('/v1/user', [BlackOps2ZMController::class, 'user']);
});
