class SessionsController < ApplicationController
  include SessionsHelper
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination" #dung .now de flash chi xuat hien 1 lan sau khi render
      render "new"
    end
  end

  def destroy
    #goi mot ham delete vao
    #chuyen huong sang root_path
    logout
    redirect_to root_path
  end
end
