class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()
    f_day = moment(today)
     

    h = today.getHours()
    m = today.getMinutes()
  
    m = @formatTime(m)
    
    @set('time', h + ":" + m )
    @set('date', f_day.format("MMMM D YYYY"))
    @set('day', f_day.format("dddd"));

  formatTime: (i) ->
    if i < 10 then "0" + i else i