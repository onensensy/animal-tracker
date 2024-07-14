<div class="content py-5 md:px-10 md:py-8">
    <x-message type="error"/>
    <x-message type="success"/>

    <table id="trip-list-table"
           class="table table-report sm:mt-2 font-medium font-semibold text-center whitespace-nowrap" data-table-sort
           data-table-pagination data-table-pagination-limit="10">
        <thead>
        <tr>
            <th class="text-left">Message</th>
            <th>From</th>
            <th>Sms status</th>
            <th>Sms sid</th>
            <th>Sms message sid</th>
            <th>Message sid</th>
        </tr>
        </thead>

        <tbody class="bg-white">
        @foreach($list as $notification)
            <tr>
                <td class="text-left">{{ $notification->body }}</td>
                <td>{{ $notification->from }}</td>
                <td>{{ $notification->sms_status }}</td>
                <td>{{ $notification->sms_sid }}</td>
                <td>{{ $notification->sms_message_sid }}</td>
                <td>{{ $notification->message_sid }}</td>
            </tr>

        @endforeach
        </tbody>
    </table>

</div>

