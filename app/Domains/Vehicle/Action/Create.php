<?php declare(strict_types=1);

namespace App\Domains\Vehicle\Action;

use App\Domains\Vehicle\Model\Vehicle as Model;

class Create extends CreateUpdateAbstract
{
    /**
     * @return void
     */
    protected function save(): void
    {
        // dd($this->data);
        $data = request()->all();

        $this->row = Model::query()->create([
            'name' => $this->data['name'],
            'plate' => $this->data['plate'],
            'timezone_auto' => $this->data['timezone_auto'],
            'enabled' => $this->data['enabled'],
            'timezone_id' => $this->data['timezone_id'],

            'species' => $data['species'],
            'age' => $data['age'],
            'gender' => $data['gender'],
            // 'habitat' => $data['habitat'],
            // 'weight' => $data['weight'],

            'user_id' => $this->data['user_id'],
        ]);
    }
}
