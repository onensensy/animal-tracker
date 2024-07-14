<nav class="side-nav">
    <ul>
        <li>
            <livewire:notifications.notification-icon />

            <a href="{{ route('dashboard.index') }}" class="logo {{ str_starts_with($ROUTE, 'dashboard.') ? 'active' : '' }}">
                @svg('/build/images/logo.svg')
            </a>
        </li>
        <div class="d-flex justify-content-center">
        </div>

        @include ('layouts.molecules.in-sidebar-menu')
    </ul>
</nav>
