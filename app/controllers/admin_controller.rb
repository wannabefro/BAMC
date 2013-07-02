class AdminController < ApplicationController
  before_filter :authorize_user

  protected

  def authorize_user
    redirect_to root_path, notice: 'You are not authorized!' unless current_user && current_user.is_admin?
  end
end
