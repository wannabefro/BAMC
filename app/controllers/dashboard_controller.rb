class DashboardController < ApplicationController
  def index
    @my_beats = Beat.free
    @tracks = Track.where(user_id: current_user)
  end
end
