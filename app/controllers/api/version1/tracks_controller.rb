module Api
  module Version1
    class TracksController < ApplicationController

      def index
        @tracks = Track.all
        respond_to do |format|
          format.json { render json: @tracks, root: false }
        end
      end

    end
  end
end
