class SessionsController < ApplicationController

  def new
  end
 

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to users_path, :notice => "Signed in!"
  end

def destroy
  session[:user_id] = nil
  reset_session
  redirect_to root_url, :notice => "Signed out!"
end

  # def create
  #   # user = User.find_by_email(params[:session][:email])
  #   # if user && user.authenticate(params[:session][:password])
  #   #   session[:user_id] = user.id
  #   #   redirect_to items_path, notice: "Logged in successfully."
  #   # else
  #   #   flash.now.alert = "Invalid login or password."
  #   #   render 'new'
  #   # end

  #   raise user = User.from_omniauth(env["omniauth.auth"]).to_yaml
  #   # session[:user_id] = user.id
  #   # redirect_to items_path, notice: "signed in!"
  # end
  
  # def destroy
  #   session[:user_id] = nil
  #   flash[:notice] = "You have been logged out."
  #   redirect_to items_path
  # end

end
