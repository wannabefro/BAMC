class Beat < ActiveRecord::Base

  GENRE = ['Old School', 'Pop', 'Alternative', 'Reggae', 'Underground', 'Jazzy', 'R&B']
  PRICE = [0.00, 0.99]

  attr_accessible :beat, :genre, :name, :price

  validates :beat, :genre, :name, :price, presence: true

  validates :genre, inclusion: { in: GENRE }
  validates :price, inclusion: { in: PRICE }

  has_attached_file :beat,
          path: "beats/:id.:extension"

  def self.free
    where("price = '0.00'")
  end

  def self.premium
    where("price > '0.00'")
  end

end
