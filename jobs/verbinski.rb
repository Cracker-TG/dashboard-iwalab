require './lib/forecast'

current = current_day
upcoming_week = this_week

SCHEDULER.every '5m', :first_in => 0 do |job|
  send_event('verbinski', { 
    current: current,
    upcoming_week: this_week,
    })
end
