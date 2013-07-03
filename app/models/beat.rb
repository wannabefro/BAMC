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
          path: "beats/:name.:extension"
  validates_attachment_content_type :audio,
    :content_type => [ 'audio/mpeg', 'audio/x-mpeg',
    'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3',
    'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]

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
