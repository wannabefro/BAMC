# encoding: utf-8

include CarrierWave::MimeTypes
process :set_content_type

class UserBeatUploader < CarrierWave::Uploader::Base
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelpers
 storage :fog
 
 def store_dir
   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}":q

 end
end
