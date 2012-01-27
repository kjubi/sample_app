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

require 'digest'

class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :email, :name, :password, :password_confirmation
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :name, 	:presence => true,
							:length => {:maximum => 50}
							
	validates :email, :presence => true,
							:format => {:with => email_regex},
							:uniqueness => {:case_sensitive => false}

	validates :password, :presence => true,
								:confirmation => true,
								:length => {:within => 6..40}
	before_save :encrypt_password
	
	# check digestion of submitted password against hash from database
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
private 

	# wrap function for pass encryption
	def encrypt_password
		self.salt = make_salt unless has_password?(password)
		self.encrypted_password = encrypt(password)
	end

	# encryption implementation
	def encrypt(word)
		secure_hash("#{salt}--#{word}")
	end
	
	# generating salt for spicing a password
	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end


	# wrap for SHA digest function
	def secure_hash(str)
		Digest::SHA2.hexdigest(str)
	end
	
		
end
