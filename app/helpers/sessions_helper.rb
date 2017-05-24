module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id #tao mot hash cua session_id cua nguoi dung hien tai 
                                    #map voi user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    #lay thong tin nguoi dung hien tai bang cach tim thong qua id cua session hien tai
  end

  def logged_in?
    !current_user.nil? #kiem tra co nguoi dung hien tai dang nhap vao ko
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
