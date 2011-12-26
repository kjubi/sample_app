class PagesController < ApplicationController
	
	
#	def titleGen2
#		baseTitle = "Let's go cinema look"
#		if @title.nil?
#			return baseTitle
#		else
#			return baseTitle + " | " + @title
#		end
#	end

  def home
		@title = "Home"
#		@con = self;
#		@test = @con.titleGen2;
		
  end

	def contact
  		@title = "Contacts"
	end
  
	def about
  		@title = "About"
 	end
 	
 	def help
 		@title = "Help page"
	end
	


end
