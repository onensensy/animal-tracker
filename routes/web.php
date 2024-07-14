<?php

use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Route;
use Twilio\TwiML\MessagingResponse;

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
    $req = request();

    $smsStatus = $req->SmsStatus;
    $smsSid = $req->SmsSid;
    $smsMessageSid = $req->SmsMessageSid;
    $messageSid = $req->MessageSid;
    $from = $req->From;
    $body = $req->Body;

    Log::info('----');
    Log::info('NEW VIA GET: ' . $body);
    Log::info('----');

    $response = new MessagingResponse();
    return $response->message("All Good");

})->name('me');
