class BeatsController < ApplicationController

  def index
    @free_beats = Beat.free
    @premium_beats = Beat.premium
  end


  def download
    @beat = Beat.find(params[:id])
    data = open(@beat.beat.url)
    send_data data.read, type: @beat.beat_content_type, filename: @beat.name, x_sendfile: true
  end

end
