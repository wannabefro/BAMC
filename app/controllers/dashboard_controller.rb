class DashboardController < ApplicationController
  before_filter :authorize_user

  def index
    @my_beats = Beat.free
    @private_tracks = Track.private.where(user_id: current_user)
    @public_tracks = Track.public.where(user_id: current_user)
  end

  protected

  def authorize_user
    redirect_to root_path, notice: 'You are not authorized!' unless current_user && current_user.is_admin?
  end

end
