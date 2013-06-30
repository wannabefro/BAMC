class Beat < ActiveRecord::Base
  attr_accessible :beat_url, :genre, :name, :price

  validates :beat_url, :genre, :name, :price, presence: true
end
