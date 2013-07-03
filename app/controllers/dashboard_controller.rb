class DashboardController < ApplicationController
  def index
    @my_beats = Beat.free
  end
end
