require "open-uri"

class Track < ActiveRecord::Base
  before_destroy :destroy_all_humans
  extend FriendlyId
  friendly_id :name, use: :slugged
  STATE = ['public', 'private']
  MAX_TRACKS = 5
  attr_accessible :beat, :name, :track, :user, :state

  state_machine :state, :initial => :public do
    event :privatize do
      transition [:public] => :private
    end

    event :publicize do
      transition [:private] => :public
    end
  end

  validates :beat, :user, presence: true

  belongs_to :user
  belongs_to :beat

  def self.public
    where("state = 'public'")
  end

  def self.private
    where("state = 'private'")
  end


  def destroy_all_humans
    url = track.sub("http://s3.amazonaws.com/#{ENV['AWS_BUCKET']}/", '')
    s3 = AWS::S3.new
    bucket = s3.buckets[ENV['AWS_BUCKET']]
    bucket.objects[url].delete
  end

    def max_tracks
    if self.tracks.count >= MAX_TRACKS
      errors[:max_tracks] << 'You can only have 5 tracks at a time'
    end
  end




end
