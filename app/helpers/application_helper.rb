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
end
