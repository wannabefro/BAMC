class TracksController < ApplicationController
before_filter :authorize_user

  def new
    @beat = Beat.find(params[:beat_id])
    @user = current_user
    @track = @beat.tracks.build
    @track.user = @user
  end

  def create
    # # @beat = Beat.find(params[:beat_id])
    # @user = current_user
    # @track = Track.new(params[:track])
    # @track.user = @user
    # if @track.save
    #   redirect_to root_path, notice: 'Successfully uploaded track'
    # else
    #   render 'new'
    # end
  end

  private

  def authorize_user
    redirect_to root_path, notice: 'You need to sign in first' unless current_user
  end
end
