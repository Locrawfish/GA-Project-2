class UsersController < ApplicationController
before_action :logged_in_user, except: [:new, :create]
before_action :verify_correct_user, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Residual Fare!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def verify_correct_user
       user = User.find_by(id: params[:id])
       redirect_to root_path, notice: 'Access Denied!' unless current_user?(user)
     end
end
