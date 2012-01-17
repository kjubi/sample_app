module ApplicationHelper
	#return page title considering existence of @title varaible
	def titleGen
		baseTitle = "Let's go cinema look"
		if @title.nil?
			return baseTitle
		else
			return baseTitle + " | " + @title
		end
	end
	
	def logo
		image_tag("logo.png", :alt => "Go2Cinema", :class => "round")
	end
end
