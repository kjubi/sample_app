require 'spec_helper'

describe "LayoutLinks" do
	it "should have a homepage at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end
	
	it "should have a contacts at '/contacts'" do
		get '/contacts'
		response.should have_selector('title', :content => "Contacts")
	end
	
	it "should have an About page at '/about'" do
		get '/about'
		response.should have_selector('title', :content => "About")
	end
	it "should have a Help page at '/help'" do
		get '/help'
		response.should have_selector('title', :content => "Help")
	end
end
