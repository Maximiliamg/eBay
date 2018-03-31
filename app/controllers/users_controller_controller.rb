class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def index 
    render_ok User.all
  end

  def create
    user = User.new user_params
    save_and_render user
  end

  def update 
    @user.update_attributes user_params 
    save_and_render @user
  end

  def destroy
    render_ok @user.destroy  
  end

  def schedule 
    if @current_user.storage
      sp = ScrapingPomelo.new
      sp.load(@current_user.storage.path)
      render_ok sp.temporal_student.schedule
    else
      render json: {message: "the schedule isn't fetched"}, status: :unprocessable_entity 
    end
  end

  private 
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.permit(
      :email,
      :password,
      :username
    )
  end
end
