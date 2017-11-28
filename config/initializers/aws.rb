AWS.config(
  :access_key_id => ENV['AKIAIL6A3U5P6KVS7BYA'],
  :secret_access_key => ENV['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']
)

S3_BUCKET =  AWS::S3.new.buckets[ENV['matatugalore']]