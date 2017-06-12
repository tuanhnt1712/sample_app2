module SessionsHelper
  #thuc hien luu id mot session khi dang nhap
  def log_in(user)
    session[:user_id] = user.id #tao mot hash cua session_id cua nguoi dung hien tai 
                                    #map voi user.id
  end

  #tra ve mot nguoi dung hien tai
  def current_user
    if (user_id = session[:user_id]) #kiem tra session co chua, neu co thi gan user_id = id_session tra ve true
      @current_user ||= User.find_by(id: user_id) #gan current_user tim theo user_id vua gan
    elsif (user_id = cookies.signed[:user_id]) #ky cookies tranh gia mao
      user = User.find_by(id: user_id) #gan user = user tim duoc bang id o tren
      if user && user.authenticated?(:remember, cookies[:remember_token]) #kiem tra remember degest
        log_in user
        @current_user = user
      end
    end
  end

  #tra ve true neu user la user hien tai
  def current_user?(user)
    user == current_user
  end

  #nho mot nguoi dung trong 1 session
  def remember(user)
    user.remember #goi ham o bwn helper tao ra 1 the nho va luu chung vao co so du lieu
    cookies.permanent.signed[:user_id] = user.id #gan id cu user cho 1 hash cua cookies
    cookies.permanent[:remember_token] = user.remember_token #gan token da tao cho 1 hash remember_token
    #tao cookies vinh vien cho id nguoi dung va ghi nho ma thong bao do
  end

  #kiem tra nguoi dung da dang nhap hay chua
  def logged_in?
    !current_user.nil? #kiem tra co nguoi dung hien tai dang nhap vao ko
  end

  #thuc hien xoa session nguoi dung
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
