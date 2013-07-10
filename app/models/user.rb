class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :year, :avatar
  has_attached_file :avatar, :styles => { :regular => "250x250>" }, :default_url => "/assets/default.svg"

  validates :username, presence: true

  has_many :tracks

  def is_admin?
    admin
  end

end
