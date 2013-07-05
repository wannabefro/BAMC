require "open-uri"
class Track < ActiveRecord::Base
  attr_accessible :beat, :name, :track, :user

  validates :beat, :user, presence: true

  belongs_to :user
  belongs_to :beat


end
