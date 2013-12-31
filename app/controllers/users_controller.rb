class UsersController < ApplicationController
  def index

  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to controller: :questions, action: :index
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :dispname, :firstname, :lastname, :password, :password_confirmation)
  end
end
