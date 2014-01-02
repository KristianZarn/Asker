class UsersController < ApplicationController
  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
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
