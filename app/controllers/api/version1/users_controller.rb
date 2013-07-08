module Api
  module Version1
    class UsersController<ApplicationController

      def index
        @users = User.all
        respond_to do |format|
          format.json {render json: @users}
        end
      end

    end
  end
end
