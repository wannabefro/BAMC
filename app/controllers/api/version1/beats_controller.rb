module Api
  module Version1
    class BeatsController<ApplicationController
      def index
        @beats = Beat.all
        respond_to do |format|
          format.json {render json: @beats}
        end
      end
    end
  end
end
