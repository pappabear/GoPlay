class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
    @users = User.paginate(page: params[:page])
  end


  def show
    @user = User.find(params[:id])
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      @user.email_hq_about_new_user
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  

  def edit
  end


  def update
    params[:user][:activity_ids] ||= []

    if !params[:user][:receive_basic_notifications].nil?
      @user.receive_basic_notifications = true
    else
      @user.receive_basic_notifications = false
    end

    if !params[:user][:receive_urgent_notifications].nil?
      @user.receive_urgent_notifications = true
    else
      @user.receive_urgent_notifications = false
    end

    if @user.update_attributes(user_params)
      flash[:success] = "Settings updated"
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end
  

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  

  private
    

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :zip, :dob, {:activity_ids => []},
                                   :basic_notifications_mode, :basic_notifications_email,
                                   :receive_basic_notifications, :receive_urgent_notifications, :phone)
    end
    

    # Before filters
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end


    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


end
