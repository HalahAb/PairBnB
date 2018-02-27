#controller to overide clearance user's controllers

class UsersController < Clearance::UsersController

  private

  def user_params
    params[:user].permit(:email, :password, :name, :image)
  end
end