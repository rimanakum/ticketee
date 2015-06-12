require 'spec_helper'

describe User do
	it "requires an email" do
		u = User.new(name: "steve",
		password: "hunter2",
		password_confirmation: "hunter2")
		u.save
		expect(u).to_not be_valid
		u.email = "steve@example.com"
		u.save
		expect(u).to be_valid
	end
	describe "passwords" do
		it "needs a password and confirmation to save" do
			u = User.new(name: "rimanakum", email: "nakumrima@gamil.com")
			u.save
			expect(u).to_not be_valid
			u.password = "rima123"
			u.password_confirmation = ""
			u.save
			expect(u).to_not be_valid
			u.password_confirmation = "rima123"
			u.save
			expect(u).to be_valid
		end
		it "needs password and confirmation to match" do
			u = User.create(
			name: "rima.nkaum",
			password: "rima123",
			password_confirmation: "rima")
			expect(u).to_not be_valid
		end
	end
	describe "authentication" do
		let(:user) { User.create(
			name: "rima.nakum",
			password: "rima123",
			password_confirmation: "rima123") }
		it "authenticates with a correct password" do
			expect(user.authenticate("rima123")).to be
		end
		it "does not authenticate with an incorrect password" do
			expect(user.authenticate("hunter1")).to_not be
		end
	end
		
end

