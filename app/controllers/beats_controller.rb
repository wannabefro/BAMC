class BeatsController < ApplicationController
  before_filter :is_admin?


  def index
    @beats = Beat.all
  end

  def new
    @beat = Beat.new
  end

  def create
    @beat = Beat.new(params[:beat])
    if @beat.save
      redirect_to beats_path, notice: 'Successfully uploaded beat'
    else
      render 'new'
    end
  end

  private

  def is_admin?
    unless user_signed_in? && current_user.admin
      redirect_to root_path
    end
  end

end
