class DashboardController < ApplicationController

  def index
    @my_beats = Beat.free
    @private_tracks = Track.private.where(user_id: current_user)
    @public_tracks = Track.public.where(user_id: current_user)
  end

end
