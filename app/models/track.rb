class Track < ActiveRecord::Base
  attr_accessible :beat, :name, :track, :user

  validates :beat, :user, presence: true

  belongs_to :user
  belongs_to :beat

  has_attached_file :track,
          path: "tracks/:id.:extension"
end
