class TracksController < ApplicationController
# before_filter :authorize_user

  def new
    @beat = Beat.find(params[:beat_id])
    @user = current_user
    @track = @beat.tracks.build
    @track.user = @user
    @track_beat = @beat
  end

  def create
    # @beat = Beat.find(30)
    # @user = current_user
    # @track = Track.new(params[:track])
    # @track.track = params["_json"]
    # @track.user = @user
    # if @track.save
    #   redirect_to root_path, notice: 'Successfully uploaded track'
    # else
    #   render 'new'
    # end
  end

  def upload
    binding.pry
    @beat = Beat.find(params["beat_id"].to_i)
    @user = current_user
    @track = Track.new(params[:track])
    @track.beat = @beat
    @track.track = params["usertrack"]
    @track.user = @user
    if @track.save
      redirect_to root_path, notice: 'Successfully uploaded track'
    else
      render 'new'
    end
  end



  private

  def authorize_user
    redirect_to root_path, notice: 'You need to sign in first' unless user_signed_in?
  end
end
