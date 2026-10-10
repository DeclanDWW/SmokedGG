<?php

use App\Http\Controllers\Api\BlackOps2ZMController;
use Illuminate\Support\Facades\Route;

Route::middleware('api.auth')->group(function () {
    // Listeners
    Route::post('/v1/listenPlayerConnected', [BlackOps2ZMController::class, 'listenPlayerConnected']);
    Route::post('/v1/listenEndGame', [BlackOps2ZMController::class, 'listenEndGame']);
    Route::post('/v1/listenPlayerDisconnected', [BlackOps2ZMController::class, 'listenPlayerDisconnected']);

    // Commands
    Route::post('/v1/commandDeposit', [BlackOps2ZMController::class, 'commandDeposit']);
    Route::post('/v1/commandGodmode', [BlackOps2ZMController::class, 'commandGodmode']);
    Route::post('/v1/commandHelp', [BlackOps2ZMController::class, 'commandHelp']);
    Route::post('/v1/commandWithdraw', [BlackOps2ZMController::class, 'commandWithdraw']);
});
