class TracksController < ApplicationController
before_filter :authorize_user, except: [:show]

  def new
    @beat = Beat.find(params[:beat_id])
    @user = current_user
    @track = @beat.tracks.build
    @track.user = @user
    @track_beat = @beat
  end

  def create
  end

  def show
    @track = Track.find(params[:id])
  end

  def upload
    @beat = Beat.find(params["beat_id"].to_i)
    @user = current_user
    @track = Track.new(params[:track])
    @track.beat = @beat
    @track.name = params["track_name"]
    @track.track = params["trackurl"]
    @track.user = @user
    if @track.save
      render :json => {:location => url_for(:controller => 'dashboard', :action => 'index')}
    end
  end

  def public
    @track = Track.find(params[:id])
    @track.publicize
    redirect_to :back
  end

  def private
    @track = Track.find(params[:id])
    @track.privatize
    redirect_to :back
  end

  private

  def authorize_user
    redirect_to root_path, notice: 'You need to sign in first' unless user_signed_in?
  end
end
