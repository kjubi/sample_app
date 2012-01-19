class UserController < ApplicationController
  def new
		@title = "Sign up page"
  end
  
  def show
  		@user = User.find(params[:id])
 	end

end
