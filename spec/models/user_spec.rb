# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do

#	
#	username validation tests #################################
#
	before (:each) do
		@attr = {:name => "Example Me", :email => "user@gmail.com"}
	end
	
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
	
end









