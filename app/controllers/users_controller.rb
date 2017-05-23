class UsersController < ApplicationController
	def index
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find_by(id: params[:id])

	end

	def create
  	@user = User.new(user_params) #lay co so du lieu tu new
  	if @user.save
  		redirect_to @user #chuyen huong sang trang khac
  		flash[:success] = "Welcome to the Sample App!"
  		#thong bao thanh cong
  	else
  		render "new"
  	end
  end

  def destroy
  	
  end 
 

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
