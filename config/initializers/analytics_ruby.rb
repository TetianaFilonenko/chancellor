Analytics = Segment::Analytics.new(
  :write_key => ENV.fetch('SEGMENT_IO_WRITE_KEY'),
  :on_error => proc { |_status, msg| Rails.logger.error(msg) },
  :stub => Rails.env != 'production'
)
