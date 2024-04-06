<?php declare(strict_types=1);

namespace App\Domains\AlarmNotification\Job;

use App\Domains\AlarmNotification\Model\AlarmNotification as Model;
use App\Domains\Core\Job\JobAbstract as JobAbstractCore;

abstract class JobAbstract extends JobAbstractCore
{
    /**
     * @var \App\Domains\AlarmNotification\Model\AlarmNotification
     */
    protected Model $row;

    /**
     * @param int $id
     *
     * @return void
     */
    public function __construct(protected int $id)
    {
    }

    /**
     * @return array
     */
    public function middleware(): array
    {
        return [$this->middlewareWithoutOverlapping()->expireAfter(30)];
    }

    /**
     * @return \App\Domains\AlarmNotification\Model\AlarmNotification
     */
    protected function row(): Model
    {
        return $this->rowOrDeleteAndException(Model::class);
    }
}
