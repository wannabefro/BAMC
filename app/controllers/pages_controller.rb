class PagesController < ApplicationController
  def index
    @free_beats = Beat.free
    @premium_beats = Beat.premium
  end
end
