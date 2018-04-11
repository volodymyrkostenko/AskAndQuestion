require 'rails_helper'
RSpec.feature "Editing ask" do
	before do
		@user = FactoryGirl.create(:user)
		@ask = FactoryGirl.create(:ask, user: @user)


	end	

	scenario "A user updates an ask" do
		login_as(@user)
		visit 'asks'
		click_link @ask.question
		click_link 'edit'
		fill_in 'ask_question', with: "lalalallalalal"
		click_button "Save changes"
		expect(page).to have_content("lalalallalalal")
		expect(page.current_path).to eq(ask_path(@ask))




	end
	scenario "A user fails to update an article" do
		login_as(@user)
		visit 'asks'
		click_link @ask.question
		click_link 'edit'
		fill_in 'ask_question', with: ""
		click_button "Save changes"
		expect(page).to have_no_content("lalalallalalal")
		expect(page.current_path).to eq(ask_path(@ask))
	end



end