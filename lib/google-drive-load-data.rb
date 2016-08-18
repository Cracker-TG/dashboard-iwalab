require 'google/apis/calendar_v3'
require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'google/api_client/client_secrets'
require 'fileutils'
require 'active_support'
require 'active_support/all'

OB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'dashboard'

SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
Google::Apis::DriveV3::AUTH_DRIVE_READONLY,
Google::Apis::DriveV3::AUTH_DRIVE_PHOTOS_READONLY

def authorize

  client_id = Google::Auth::ClientId.from_file('./lib/google_client_secret.json')

  token_store = Google::Auth::Stores::FileTokenStore.new(file: 'google-tokenStore.yaml')

  authorizer = Google::Auth::UserAuthorizer.new(
    client_id, SCOPE,token_store)

  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(
      base_url: OOB_URI)
    puts "Open the following URL in the browser and enter the " +
    "resulting code after authorization"
    puts url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
end
credentials
end


def google_calendar_event()
  service = Google::Apis::CalendarV3::CalendarService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize
  calendar_id = 'ID'

  response = service.list_events(calendar_id,
     max_results: 10,
     single_events: true,
     order_by: 'startTime',
     time_min: Time.now.iso8601)
end

#google doucments


def google_docs1()
  service = Google::Apis::DriveV3::DriveService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize

  doc1 = service.list_files(q: "name='name document'",
    spaces: 'drive',
    fields: 'files/thumbnail_link')

  doc1.files[0].thumbnail_link + '0' 
end

def google_docs2()
  service = Google::Apis::DriveV3::DriveService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize

  doc2 = service.list_files(q: "name='name document'",
    spaces: 'drive',
    fields:'files/thumbnail_link')
  doc2.files[0].thumbnail_link + '0' 

end

def google_images()
  service = Google::Apis::DriveV3::DriveService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize 
  images = service.list_files(q: "'ID' in parents",
      fields: 'files/thumbnail_link')

  images.files.collect {|i| i.thumbnail_link +  '0'}

end
