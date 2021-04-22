class LoginController < ApplicationController
  LoginMessage1 = 'ログインしました'
  LoginMessage2 = 'パスワードが間違っています'
  LoginMessage3 = 'ユーザが存在しません'

  def index
  end

  def login
    users = User.where(sprintf("email = '%s'", params[:email]))
    if users.length > 0
      if users[0].password == params[:password]
        flash[:notice] = LoginMessage1
        redirect_to '/'
      else
        flash.now[:alert] = LoginMessage2
        render :index
      end
    else
      flash.now[:alert] = LoginMessage3
      render :index
    end
  end
end
