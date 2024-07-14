<?php

use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::post('webhook-listener', function () {
    $request = request();
//    Log::info('GOT THE MESSAGE VIA POST: ' . $request->getContent());
    Log::info('GOT THE MESSAGE VIA POST: ');

    return response('Webhook listener', 200);
})->name('me');
