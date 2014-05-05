class AdminController < ApplicationController
	http_basic_authenticate_with :name => "suni_gsm", :password => "Ishvar"
  def index
  end
end
