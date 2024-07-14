<?php

namespace App\Livewire\Notifications;

use App\Models\Message;
use Livewire\Component;

class NotificationPage extends Component
{
    public $list;

    public function refreshMessages()
    {
        $this->list = Message::all();

    }

    public function markAsRead($messageId){
        $message = auth()->user()->notifications->where('id', $messageId)->first();
        $message->markAsRead();
        $this->refreshMessages();
    }


    public function render()
    {
        $this->refreshMessages();
        return view('livewire.notifications.notification-page');
    }
}
