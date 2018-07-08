class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  # :admin_user is a private method below that checks if a user is an admit before permitting the :destroy action
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    # this is equivalent to:
    # @user = User.find(1)
    # Technically, params[:id] is the string "1", but find is smart enough to convert this to an integer.
  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
    # @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to my app!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    # OR in one line:
    # User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
