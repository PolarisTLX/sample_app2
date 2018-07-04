class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    # this is equivalent to:
    # @user = User.find(1)
    # Technically, params[:id] is the string "1", but find is smart enough to convert this to an integer.
  end

  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to my app!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
