class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
  end
end




  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:message] = "Need User name and password"
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end


  def omniauth
    user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) 
      user.username = auth['info']['first_name']
      user.name = auth['info']['first_name']
      user.email = auth['info']['email']
      user.password = SecureRandom.hex(16)

      if user.save
        session[:user_id] = user.id
        redirect_to root_path
      else
        #flash[:message] = @user.errors.full_messages
        redirect_to login_path
    end
  
  end


  private
  def auth 
  request.env['omniauth.auth']
  end









end
