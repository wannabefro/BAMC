class Admin::BeatsController < AdminController

  before_filter :authorize_user

  def index
    @beats = Beat.all
  end

  def new
    @beat = Beat.new
  end

  def create
    @beat = Beat.new(params[:beat])
    binding.pry
    if @beat.save
      redirect_to admin_beats_path, notice: 'Successfully uploaded beat'
    else
      render 'new'
    end
  end

  def edit
    @beat = Beat.find(params[:id])
  end

  def update
    @beat = Beat.find(params[:id])
    if @beat.update_attributes(params[:beat])
      redirect_to admin_beats_path, notice: 'Successfully uploaded beat'
    else
      redirect_to admin_beat_path(@beat)
    end
  end

  protected

  def authorize_user
    redirect_to root_path, notice: 'You are not authorized!' unless current_user && current_user.is_admin?
  end

end
