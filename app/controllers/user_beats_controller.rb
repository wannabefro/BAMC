class UserBeatsController < ApplicationController
  
  def new
    @user_beat = UserBeat.new
  end

end
