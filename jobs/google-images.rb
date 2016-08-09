require './lib/google-drive-load-data'
images = google_images()
image_counter = 0

SCHEDULER.every '10m' do
	images = google_images()
	image_counter = 0
end

SCHEDULER.every '10s' do
	send_event('slider',{ image: images[image_counter]})
	image_counter = (image_counter + 1) % images.length
end