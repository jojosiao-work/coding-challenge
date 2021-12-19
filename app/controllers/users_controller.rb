class UsersController < ApplicationController
  
  # new user registration
  def register
    @user  = User.new
    if request.method == "POST"
      user = params[:user]
      @user.email = user[:email]
      @user.password = user[:password]
      if @user.valid?
        @user.save
        flash[:notice] = "registration successful. You may log in."
        redirect_to "/users/login"
      end
    end 

  end


  def login
    if session[:user_id]
      redirect_to "/posts"
    end

    if request.method == "POST" && !params.empty?
      @user = User.where(email: params[:email], password: params[:password]).first
      if @user
        session[:user_id] = @user.id
        session[:email] = @user.email
        flash[:notice] = "Login successful."
        redirect_to "/posts"
      else
        flash[:notice] = "login failed."
      end
    end

  end

  def logout
    if session[:user_id]
      reset_session
      flash[:notice] = "You are logged out."
    end
  
    redirect_to "/users/login"
  
  end 

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end

end