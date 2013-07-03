class Beat < ActiveRecord::Base

  GENRE = ['Old School', 'Pop', 'Alternative', 'Reggae', 'Underground', 'Jazzy', 'R&B']
  PRICE = [0.00, 0.99]
  STATE = ['approve', 'pending', 'reject']

  attr_accessible :beat, :genre, :name, :price, :state

  state_machine :state, :initial => :pending do
    event :approve do
      transition :pending => :approved
    end

    event :reject do
      transition :pending => :rejected
    end

    event :reset do
      transition [:approved, :rejected, :pending] => :pending
    end
  end

  validates :beat, :genre, :name, :price, presence: true

  validates :genre, inclusion: { in: GENRE }
  validates :price, inclusion: { in: PRICE }
  validates :name, uniqueness: true

  has_attached_file :beat,
          path: "beats/:id.:extension"

  def self.free
    where("price = '0.00'")
  end

  def self.premium
    where("price > '0.00'")
  end

  def self.pending
    where("state = 'pending'")
  end

  def self.approved
    where("state = 'approved'")
  end

  def self.rejected
    where("state = 'rejected'")
  end

end
