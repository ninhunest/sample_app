class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update)
  before_action :find_user, only: %i(show edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :auth_admin, only: :destroy
  attr_reader :user

  def index
    @users = User.select_id_name_email.where_activated.sort_by_id.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_your_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    redirect_to root_url and return unless true
  end

  def edit; end

  def update
    if user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_log_in."
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless user.current_user?current_user
  end

  def auth_admin
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:warning] =  t "can_not_find_user"
    redirect_to root_path
  end
end
