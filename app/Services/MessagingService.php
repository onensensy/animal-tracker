<?php

namespace App\Services;

use Twilio\Rest\Client;

class MessagingService
{

    public function __construct()
    {
    }

    public function sendSMS($message,$to = null)
    {
        $sid = env("TWILLIO_SID");
        $token = env("TWILLIO_TOKEN");

        $to =  !is_null($to) ? $to :env("TWILLIO_TO");


        $twilio = new Client($sid, $token);

        $message = $twilio->messages
            ->create($to, // to
                [
                    "body" => $message,
                    "from" => env("TWILLIO_FROM")
                ]
            );

        return $message;
    }

}
