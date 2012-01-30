require 'spec_helper'

describe UsersController do
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
			get :new
			response.should be_success
		end

		it "should have the right title" do
			get :new
			response.should have_selector("title", :content => "Sign up page")
		end
	end
  	
  	describe "POST 'create'" do
  		describe "failure" do
  			before (:each) do
  				@attr = {:name => "", :email => "", :password => "", :password_confirmation => ""}
 			end
 			
 			it "should not create user" do
 				lambda do
 					post :create, :user => @attr
				end.should_not change(User, :count)
			end
			
			it "should have right title" do
				post :create, :user => @attr
				response.should have_selector("title", :content => "Sign up")
			end
			
			it "should render the 'new' page" do
				post :create, :user => @attr
				response.should render_template("new")
			end
 		end
 		
 		describe "success" do
 			before (:each) do
  				@attr = {:name => "Yurgen Stepov", :email => "estar@gmail.com", :password => "validpass", :password_confirmation => "validpass"}
 			end
 			
 			it "should create user" do
 				lambda do
 					post :create, :user => @attr
				end.should change(User, :count).by(1)
			end
			
			it "should redirect to user profile page" do
				post :create, :user => :@attr
				response.should redirect_to(user_path(assigns(:user)))
			end
			
			it "should contain welcome message" do
				post :create, :user => :@attr
				flash[:success].should =~ /welcome to where to go!/i
			end
			
		end
 		
 		
 	end
  	

end
