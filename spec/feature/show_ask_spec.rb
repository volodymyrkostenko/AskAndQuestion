require "rails_helper"
RSpec.feature "Showing an ask" do 
	before do 
		@user = FactoryGirl.create(:user)
		@ask = FactoryGirl.create(:ask, user: @user)
		10.times{FactoryGirl.create(:answer, ask: @ask, user: @user)} 
	end

	scenario "visit with sign in" do
		login_as(@user)
		visit 'asks'
		click_link @ask.question
		expect(page).to have_content(@ask.question)
		@ask.answers.each{|answer| expect(page).to have_content(answer.body)}

	end

	scenario "without user" do
		
		visit "asks"
		expect(page.current_path).to eq(new_user_session_path)
	end
end