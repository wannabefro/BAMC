class UserBeat < ActiveRecord::Base
  attr_accessible :beat

  has_attached_file :beat

  belongs_to :user,
    inverse_of: :user_beats

end
