class UsersController < ApplicationController
  
  before_action :not_signed_in_user,   only: [:new, :create]
  before_action :signed_in_user,       only: [:index, :edit, :update, :destroy]
  before_action :correct_user,         only: [:edit, :update]
  before_action :admin_user,           only: [:index, :destroy]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    
    @user = User.new(user_params)
    
    if @user.save
      sign_in @user
      flash[:success] = "Hi, #{@user.name}"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if current_user != @user && default_user != @user
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def not_signed_in_user
    if signed_in?
      redirect_to root_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user || current_user.admin?
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
