# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do


	before (:each) do
		@attr = 
		{
			:name => "Example Me", 
			:email => "user@gmail.com",
			:password => "foobar",
			:password_confirmation => "foobar"
		}
	end
#	
#	username validation tests #################################
#	
	
	it "should create a new instance given valid attributes" do
		User.create!(@attr)
	end
	
	it "should require a name" do
		no_nameUs = User.new(@attr.merge(:name => ""))
		no_nameUs.should_not be_valid
	end
	
	it "should require a email" do
		no_emailUs = User.new(@attr.merge(:email => ""))
		no_emailUs.should_not be_valid
	end
	
	it "should reject too long names" do
		longName = "a"*51
		longNameUser = User.create(@attr.merge(:name => longName))
		longNameUser.should_not be_valid
	end

#	
#	user email validation tests #################################
#	
	it "should accept valid email" do
		emails = %w[user@foo.com user.new@foo.jp THE_USVER@foo.bar.org]
		
		emails.each do |mail|
			validMailUser = User.new(@attr.merge(:email => mail))
			validMailUser.should be_valid
		end
	end
	
	it "should accept valid email" do
		emails = %w[user@foo,com user.new_at_foo.com THE_USVER@foo.]
		emails.each do |mail|
			invalidMailUser = User.new(@attr.merge(:email => mail))
			invalidMailUser.should_not be_valid
		end
	end
	
	it "should reject dublicates in emails" do
		upcasedEmail = @attr[:email].upcase
		User.create!(@attr.merge(:email => upcasedEmail))
		userDublicate = User.new(@attr)
		userDublicate.should_not be_valid
	end

#	
#	user password validation tests #################################
#		
	describe "Password validation" do
		it "should require a password" do
			User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
		end
		
		it "should require a password matching a confirmation" do
			User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
		end
		
		it "should reject too short passwords" do
			a = "a"*5
			User.new(@attr.merge(:password => a, :password_confirmation => a)).should_not be_valid
		end

		it "should reject too long passwords" do
			longPass = "a"*41
			User.new(@attr.merge(:password => longPass, :password_confirmation => longPass)).should_not be_valid
		end
	end

#	
#	user encrypted password creation tests #################################
#			
	describe "password encryption" do
		before(:each) do
			@user = User.create!(@attr)
		end
		
		it "should have an encrypted password attribute" do
			@user.should respond_to(:encrypted_password)
		end
		
		it "should set encrypted password" do
			@user.encrypted_password.should_not be_blank
		end
		
		describe "has_password? method" do
			it "should be true if the passwords match" do 
				@user.has_password?(@attr[:password]).should be_true
			end
			
			it "should be false if the passwords differ" do 
				@user.has_password?("invalid").should be_false
			end
			
		end
		
		describe "authenticate method" do
			it "should return nil on email/password mismatch" do
				wrong_pass_user = User.authenticate(@attr[:email], "wroooong")
				wrong_pass_user.should be_nil
			end
			
			it "should return nil on email unable to find in database" do
				wrong_email_user = User.authenticate("bart@bass.com", @attr[:password])
				wrong_email_user.should be_nil
			end
			
			it "should return user on email/password match" do
				ok_user = User.authenticate(@attr[:email], @attr[:password])
				ok_user.should == @user
			end
		end
	end
	
	
	
	
	

end









