class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def index
    @users = User.search(params[:search]).paginate(page: params[:page], per_page: 9)
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
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :dispname, :firstname, :lastname, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
