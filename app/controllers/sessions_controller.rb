class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
      if user && user.authenticate(params[:session][:password])
	if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
        else
        cookies[:auth_token] = user.auth_token
        end   
        sign_in user
        redirect_back_or user
      else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
    end
  end

  def destroy
    sign_out
    cookies.delete(:auth_token)
    redirect_to root_path, notice: "Signed out!"	  
  end
end
