class UsersController < ApplicationController
  def new
    @user = User.new
    render 'users/login'
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to new_user_path
    end
  end

  def show
    user = User.find(params[:id])
    if user == current_user
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :admin)
    end
end
