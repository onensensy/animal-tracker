<?php declare(strict_types=1);

namespace App\Domains\Device\Controller;

use App\Services\MessagingService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;
use App\Domains\Device\Service\Controller\Create as ControllerService;

class Create extends ControllerAbstract
{
    /**
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function __invoke(): Response|RedirectResponse
    {
        if ($response = $this->actionPost('create')) {
            return $response;
        }

        $this->meta('title', __('device-create.meta-title'));

        return $this->page('device.create', $this->data());
    }

    /**
     * @return array
     */
    protected function data(): array
    {
        return ControllerService::new($this->request, $this->auth)->data();
    }

    /**
     * @return \Illuminate\Http\RedirectResponse
     */
    protected function create(): RedirectResponse
    {
        #send message to bind device
        $sender = new MessagingService();
        $sender->sendSMS('000');

        $this->row = $this->action()->create();




        $this->sessionMessage('success', __('device-create.success'));

        return redirect()->route('device.update', $this->row->id);
    }
}
