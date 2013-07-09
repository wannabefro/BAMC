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
    begin
      @track = Track.find(params[:id])
      if @track.user == current_user
        @track
      elsif @track.state == 'public'
        @track
      elsif @track.state == 'private'
        redirect_to root_path, notice: 'Sorry this track is private'
      end
    rescue
      redirect_to root_path, notice: "Sorry this track doesn't exist"
    end

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

  def destroy
    @track = Track.find(params[:id])
    if @track.destroy
      redirect_to dashboard_index_path(current_user), notice: 'Successfully deleted track'
    else
      redirect_to dashboard_index_path(current_user)
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

  def download
    @track = Track.find(params[:id])
    data = open(@track.track)
    send_data data.read, type: 'audio/wav', filename: @track.name, x_sendfile: true
  end

  private

  def authorize_user
    redirect_to root_path, notice: 'You need to sign in first' unless user_signed_in?
  end

end
