require 'rails_helper'

RSpec.feature "Delete Asks" do 
	before do
		john = FactoryGirl.create(:user)
		login_as(john)
		@ask = FactoryGirl.create(:ask, user:john)

	end

	scenario "User deletes an ask" do
		visit "asks"

		click_link @ask.question
		click_link "destroy"
		expect(current_path).to eq(asks_path)


	end

end