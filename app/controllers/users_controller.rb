class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	 @user = User.new(user_params)
  	if @user.save
  		UserMailer.welcome_email(@user).deliver
  		redirect_to root_url, :notice => "Congratualtions !! Account created successfully"
  	else
  		render "new"
  	end
  end

  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end  

 end