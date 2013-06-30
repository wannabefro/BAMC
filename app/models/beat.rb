class Beat < ActiveRecord::Base
  attr_accessible :beat, :genre, :name, :price

  validates :beat, :genre, :name, :price, presence: true

  has_attached_file :beat,
          path: "beats/:id.:extension"

end
