require './lib/google-drive-load-data'

SCHEDULER.every '2m' do

  doc1 = google_docs1()
  send_event('google_docs1',{doc1: doc1})

  doc2 = google_docs2()
  send_event('google_docs2',{doc2: doc2})
end
