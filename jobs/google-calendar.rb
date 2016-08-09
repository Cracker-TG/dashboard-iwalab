
require './lib/google-drive-load-data'

SCHEDULER.every '2m', :first_in => 0 do |job|

    data_event = google_calendar_event

    send_event('google_calendar',    { events: data_event } )
   

end
