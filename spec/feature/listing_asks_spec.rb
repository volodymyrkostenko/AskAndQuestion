require 'rails_helper'

RSpec.feature "Listing asks" do 
	before do 
		@user = FactoryGirl.create(:user)
		@asks = []
		5.times {@asks << FactoryGirl.create(:ask, user: @user) }
		
	end

	scenario "with user sign in" do
		login_as(@user)
		visit "asks"
		@asks.each{ |n| expect(page).to have_content(n.question)}
	end


	scenario "without user" do
		
		visit "asks"
		expect(page.current_path).to eq(new_user_session_path)
	end

end