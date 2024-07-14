<!doctype html>
<html lang="{{ app()->getLocale() }}">
<head>
    @include ('layouts.molecules.head')
</head>

<body class="main body-{{ str_replace('.', '-', $ROUTE ??'notificaion') }} authenticated">

<div class="wrapper">
    <div class="wrapper-box">
        @include ('layouts.molecules.in-sidebar')

        <livewire:notifications.notification-page/>
    </div>
</div>

@include ('layouts.molecules.footer')
</body>
</html>
