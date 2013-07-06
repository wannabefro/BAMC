class TracksController < ApplicationController
before_filter :authorize_user

  def new
    @beat = Beat.find(params[:beat_id])
    @user = current_user
    @track = @beat.tracks.build
    @track.user = @user
    @track_beat = @beat
  end

  def create
  end


  def upload
    @beat = Beat.find(params["beat_id"].to_i)
    @user = current_user
    @track = Track.new(params[:track])
    @track.beat = @beat
    @track.name = params["track_name"]
    @track.track = params["trackurl"]
    @track.user = @user
    @track.save
  end



  private

  def authorize_user
    redirect_to root_path, notice: 'You need to sign in first' unless user_signed_in?
  end
end
