class UserMailer < ActionMailer::Base
  default from: "from@example.com"

def welcome_email(user)
	  @user = user
	  #@url = "<a href="http://localhost:3000/log_in">Login</a>"
	  @site_name = "localhost"
	  mail(:to => user.email, :subject => "Welcome to my website.")
end
end