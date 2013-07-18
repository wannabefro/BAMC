class UserBeatsController < ApplicationController

  def new
    @user_beat = UserBeat.new
  end

  def destroy
    @user_beat = UserBeat.find(params[:id])
    if @user_beat.destroy
      redirect_to dashboard_index_path(current_user), notice: 'Successfully deleted your original beat'
    else
      redirect_to dashboard_index_path(current_user)
    end
  end

   def create
    @user_beat = UserBeat.new(params[:user_beat])
    @user_beat.user = current_user
    if @user_beat.save
      redirect_to dashboard_index_path, notice: 'Successfully uploaded beat'
    else
      render 'new'
    end
  end

  def download
    @user_beat = UserBeat.find(params[:id])
    data = open(@user_beat.user_beat)
    send_data data.read, type: 'audio/wav', filename: @user_beat.name, x_sendfile: true
  end

  def public
    @user_beats = UserBeat.find(params[:id])
    @user_beats.publicize
    redirect_to :back
  end

  def private
    @user_beat = UserBeat.find(params[:id])
    @user_beat.privatize
    redirect_to :back
  end



end
