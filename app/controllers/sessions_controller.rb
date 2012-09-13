class SessionsController < ApplicationController

  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to items_path, notice: "Logged in successfully."
    else
      flash.now.alert = "Invalid login or password."
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to items_path
  end

end
