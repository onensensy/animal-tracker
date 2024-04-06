<?php declare(strict_types=1);

namespace App\Domains\Vehicle\Controller;

use Illuminate\Support\Facades\Route;

Route::group(['middleware' => ['user-auth']], static function () {
    Route::get('animals', Index::class)->name('vehicle.index');
    Route::any('animals/create', Create::class)->name('vehicle.create');
    Route::any('animals/map', Map::class)->name('vehicle.map');
    Route::any('animals/{id}', Update::class)->name('vehicle.update');
    Route::any('animals/{id}/alarm', UpdateAlarm::class)->name('vehicle.update.alarm');
    Route::any('animals/{id}/alarm-notification', UpdateAlarmNotification::class)->name('vehicle.update.alarm-notification');
    Route::any('animals/{id}/device', UpdateDevice::class)->name('vehicle.update.device');
});
