class UsersController < ApplicationController
  before_filter :signed_in_user, 
                 only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page] )
  end
  
  def new
    signed_in? ? redirect_to(root_path) : @user = User.new
    #@user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Justin's sample app!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def edit
    #@user = User.find(params[:id])
    #don't need above line now that we have the correct_user before filter
  end
  
  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Your profile is updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    unless current_user == User.find(params[:id])
      User.find(params[:id]).destroy
      flash[:success] = "User annihilated."
      redirect_to users_path
    else  #admin users cannot destroy themselves
      redirect_to(root_path)
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  
=begin ==> don't need since listed in sessions_helper, which is included in app controller
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
=end
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
