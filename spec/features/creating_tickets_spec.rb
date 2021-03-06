require 'spec_helper'
feature "Creating Tickets" do
	
	before do
		project = FactoryGirl.create(:project)
		user = FactoryGirl.create(:user)
		define_permission!(user, "view", project)
		define_permission!(user, "create tickets", project)
		@email = user.email
		sign_in_as!(user)
		visit '/'
		click_link project.name
		click_link "Show Ticket"
		click_link "New Ticket"   # change to new to show ticket link
	end

	scenario "Creating a ticket" do
		fill_in "Title", with: "Non-standards compliance"
		fill_in "Description", with: "My pages are ugly!"
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has been created.")
		within "#ticket #author" do
			expect(page).to have_content("Created by #{@email}")
		end	
	end

	scenario "Creating a ticket without valid attributes fails" do
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has not been created.")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")
	end

	scenario "Creating a ticket with an attachment" do
		fill_in "Title", with: "Add documentation for blink tag"
		fill_in "Description", with: "The blink tag has a speed attribute"
		attach_file "File", "spec/fixtures/speed.txt"
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has been created.")
		within("#ticket .asset") do
			expect(page).to have_content("speed.txt")
		end
	end
end
