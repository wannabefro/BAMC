class McsController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_beats = @user.user_beats
  end

end
