class User < ActiveRecord::Base
	attr_accessor :password
  
 	validates :email, uniqueness: true, presence: true
 				#:length => { :within => 5..50 },:format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
 	validates :password, confirmation: true, presence: true

 				#:length => { :within => 4..20 },:presence => true
 
 	before_save :encrypt_password
 	before_create { generate_token(:auth_token) }

 	def self.authenticate(email, password)
	  user = find_by_email(email)
	  if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
	    user
	  else
	    nil
	  end
	end

 	def encrypt_password
 		if password.present?
 			self.password_salt = BCrypt::Engine.generate_salt
     		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
 		end
 	end


  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

 def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  UserMailer.password_reset(self).deliver
end

end