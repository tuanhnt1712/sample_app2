class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy,
    :followers, :following]
  before_action :correct_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params) #lay co so du lieu tu new
    if @user.save
      log_in @user #de current_user lay id cua nguoi dung hien tai
      flash[:success] = "Welcome to the Sample App!"  #thong bao thanh cong
      redirect_to @user #chuyen huong sang trang khac
    else
       #chuyen ve trang new.html.erb
      flash.now[:danger] = "error_signup"
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash.now[:success] = "Profile updated"
      redirect_to @user
    else
      flash.now[:danger] = "Fail update"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Xoa roi nha :)"
    redirect_to users_url
  end 

   def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find_by(id: params[:id])
  end

  def admin_user
    redirect_to root_url unless current_user.admin? #de ngan can nguoi cung co the xoa = dong lenh nen chi admin ms co the dung ham nay
  end

  
end
