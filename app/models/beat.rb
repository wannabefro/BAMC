class Beat < ActiveRecord::Base

  GENRE = ['Old School', 'Pop', 'Alternative', 'Reggae', 'Underground', 'Jazzy', 'R&B']

  attr_accessible :beat, :genre, :name, :price

  validates :beat, :genre, :name, :price, presence: true

  validates :genre, inclusion: { in: GENRE }

  has_attached_file :beat,
          path: "beats/:id.:extension"

end
