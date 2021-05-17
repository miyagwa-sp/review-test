class TopController < ApplicationController

  def index
    redirect_to '/login' if session[:user].blank?

  end

end
