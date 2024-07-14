<?php

use App\Models\Message;
use Illuminate\Support\Facades\Auth;
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

Route::get('webhook-listener', function () {
    $req = request();

    $sms_status = $req->SmsStatus;
    $sms_sid = $req->SmsSid;
    $sms_message_sid = $req->SmsMessageSid;
    $message_sid = $req->MessageSid;
    $from = $req->From;
    $body = $req->Body;

    #SAVE MESSAGE TO DATABASE
    Message::create(
        [
            'sms_status' => $sms_status,
            'sms_sid' => $sms_sid,
            'sms_message_sid' => $sms_message_sid,
            'message_sid' => $message_sid,
            'from' => $from,
            'body' => $body,
        ]
    );


    Log::info('-----------------------------------------------------------------------------------------------');
    Log::info('MESSAGE BODY: ' . $body. ' FROM: ' . $from);
    Log::info('-----------------------------------------------------------------------------------------------');

    #GET A MODEL FOR TRIPS
    #PARSE THE BODY TO GET THE VARIOUS COMMANDS
    //$commands = explode(' ', $body);
    $removable_text = 'Sent from your Twilio Trial account -';
    $commands = explode(' ', str_replace($removable_text, '', $body));

//    pick the before the first : as the command
    $command = explode(':', $commands[0])[0];
    $command = strtolower($command);

    $response = new MessagingResponse();
    #handle the command
    switch ($command) {
        case 'set':
            #sample message: set: Bind number:+256782150448 successfully, extract the number and +
            $number = explode(':', $commands[1])[1];
            $number = str_replace(['Bind number:', ' successfully'], '', $number);
            $number = str_replace(' ', '', $number);
            $response->message("All Good");
            return $response;
            break;
        case 'loc':
            #sample message: loc: Please link:https://www.google.com/maps/place/0.313611,32.581111  Battery 20%
            $location = explode(':', $commands[1])[1];
            $location = str_replace('Please link:', '', $location);
            $location = str_replace(' ', '', $location);
            $response->message("Location Bound");
            return $response;
            break;
        default:
            $response->message("Invalid Command");
            return $response;
            break;
    }

})->name('webhook-listener');

Route::get('/notifications', function (){
    $list = Message::all();

    return view('notifications')->with(['ROUTE'=>'notifications','AUTH'=>Auth::user(),'list'=>$list]);
})->name('notifications');
