require 'spec_helper'

describe UserController do
	render_views
	

	
	describe "GET 'show'" do
		before (:each) do
#			attrib = 
#			{
#				:name => "Example Me", 
#				:email => "user@gmail.com",
#				:password => "foobar",
#				:password_confirmation => "foobar"
#			}
#			@myuser = User.create!(attrib)
#			@myuser.save
			@user = Factory(:user)
		end
		
		it "should be successful" do
			get :show, :id => @user
			response.should be_success
		end
		
		it "should find the right user" do
		   get :show, :id => @user
		   assigns(:user).should == @user
		end
		
		it "should have proper title" do
			get :show, :id => @user
			response.should have_selector("title", :content => @user.name)
		end
		
		
		it "should include username in header" do
			get :show, :id => @user
			response.should have_selector("h1", :content => @user.name)
		end


		it "should have avatar" do
			get :show, :id => @user
			response.should have_selector("h1>img", :class => "gravatar")
		end


	end


	describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
    	get 'new'
    	response.should have_selector("title", :content => "Sign up page")
    end
    

  end
  
  

end
