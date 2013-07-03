class TracksController < ApplicationController
before_filter :authorize_user

  def new
  end

  def create
  end

  private

  def authorize_user
    redirect_to root_path, notice: 'You need to sign in first' unless current_user
  end
end
