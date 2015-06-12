class User < ActiveRecord::Base
	has_secure_password
	has_many :permissions
	def to_s
		"#{email} (#{admin? ? "Admin" : "User"})"
	end
	validates :email, presence: true
end
