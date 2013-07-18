require "open-uri"

class UserBeat < ActiveRecord::Base
  before_destroy :destroy_all_humans
  attr_accessible :beat, :name, :price, :state, :genre
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :beat,
                   path: "userbeats/:id.:extension"

  belongs_to :user,
    inverse_of: :user_beats

  def destroy_all_humans
    url = beat.url.sub("http://s3.amazonaws.com/#{ENV['AWS_BUCKET']}/", '')
    s3 = AWS::S3.new
    bucket = s3.buckets[ENV['AWS_BUCKET']]
    bucket.objects[url].delete
  end

end
