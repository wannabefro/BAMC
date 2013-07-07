require "open-uri"
class Track < ActiveRecord::Base
  STATE = ['public', 'private']
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


end
