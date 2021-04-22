class LoginController < ApplicationController
  LoginMessage1 = 'ログインしました'
  LoginMessage2 = 'パスワードが間違っています'
  LoginMessage3 = 'ユーザが存在しません'
  LoginMessage4 = 'ログインが連続で失敗したので、アカウントがロックされました。<br/>しばらくしてから再度お試しください。'
  LogoutMessage = 'ログアウトしました'

  def index
  end

  def login
    users = User.where(sprintf("email = '%s'", params[:email]))
    if users.length > 0
      j = users.length - 1
      for i in 0..j do
        user = users[i]
        failedCount = user.failed_login_count
        if failedCount && failedCount > 5 && user.updated_at < Time.now.ago(5.hours)
          flash.now[:alert] = LoginMessage4
          render :index
        end
        if user.password == params[:password]
          user.last_login_at = Time.now
          user.save
          session[:user] = user
          flash[:notice] = LoginMessage1
          redirect_to '/'
          return
        else
          if failedCount == nil
            failedCount = 0
          end
          user.failed_login_count = failedCount + 1
          user.save
        end
      end
      flash.now[:alert] = LoginMessage2
      render :index
    else
      flash.now[:alert] = LoginMessage3
      render :index
    end
  end

  def logout
    session.clear
    flash[:notice] = LogoutMessage
    redirect_to '/login'
  end
end
