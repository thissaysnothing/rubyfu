class SessionsController < ApplicationController
  
def new
  @user ||= User.new
  render :new
end

def create 
  @user = User.find_by_credentials(
    params[:user][:email],
    params[:user][:password]) || User.new(params[:user][:email],
    params[:user][:password])
  if @user.persisted? && @user.activated
    log_in_user!(@user)
    redirect_to user_url(@user)
  elsif @user.persisted? & !@user.activated
    flash.now[:errors] = 'Please activate account'
    redirect_to root_url
  else
    flash.now[:errors] = 'Invalid Email or Password!'
    render :new
  end
end

def destroy
  log_out
  redirect_to bands_url
end




end
