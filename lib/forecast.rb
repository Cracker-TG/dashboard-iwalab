require 'date'
require 'net/https'
require 'json'

def time_to_str(time_obj)
  """ format: 5 pm """
  return Time.at(time_obj).strftime "%-l %P"
end

def time_to_str_minutes(time_obj)
  """ format: 5:38 pm """
  return Time.at(time_obj).strftime "%-l:%M %P"
end
  
def day_to_str(time_obj)
  """ format: Sun """
  return Time.at(time_obj).strftime "%a"
end
# Forecast API Key from https://developer.forecast.io
forecast_api_key = ""

# Latitude, Longitude for location
forecast_location_lat = "16.4321"
forecast_location_long = "102.8236"

# Unit Format
forecast_units = "ca" # like "si", except windSpeed is in kph
http = Net::HTTP.new("api.forecast.io", 443)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
response = http.request(Net::HTTP::Get.new("/forecast/#{forecast_api_key}/#{forecast_location_lat},#{forecast_location_long}?units=#{forecast_units}"))
@forecast = JSON.parse(response.body)  

def current_day
 currently = @forecast["currently"]
 current = {
  temperature: currently["temperature"].round,
  summary: currently["summary"],
  humidity: "#{(currently["humidity"] * 100).round}&#37;",
  wind_speed: currently["windSpeed"].round,
  wind_bearing: currently["windSpeed"].round == 0 ? 0 : currently["windBearing"],
  icon: currently["icon"]
}
end

def this_week
  daily = @forecast["daily"]["data"][0]
  this_week = []
  for day in (1..7) 
    day = @forecast["daily"]["data"][day]
    this_day = {
      max_temp: day["temperatureMax"].round,
      min_temp: day["temperatureMin"].round,
      time: day_to_str(day["time"]),
      icon: day["icon"]
    }
    this_week.push(this_day)
  end
  return this_week
end