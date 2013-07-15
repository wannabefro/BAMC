require 'carrierwave'

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_access_secret_key: ENV["AWS_S3_BUCKET"]
  }
  config.fog_directory = ENV["AWS_S3_BUCKET"] 
end
