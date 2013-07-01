class Beat < ActiveRecord::Base

  GENRE = ['Old School', 'Pop', 'Alternative', 'Reggae', 'Underground', 'Jazzy', 'R&B']
  PRICE = [0.00, 0.99]

  attr_accessible :beat, :genre, :name, :price, :state

  state_machine :state, :initial => :pending do
    event :approve do
      transition :pending => :approved
    end

    event :reject do
      transition :pending => :rejected
    end

    event :reset do
      transition [:approved, :rejected] => :pending
    end
  end


  validates :beat, :genre, :name, :price, presence: true

  validates :genre, inclusion: { in: GENRE }
  validates :price, inclusion: { in: PRICE }
  validates :name, uniqueness: true

  has_attached_file :beat,
          path: "beats/:id.:extension"

end
