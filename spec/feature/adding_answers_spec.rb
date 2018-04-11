 require 'capybara_helper'

RSpec.feature "Adding answers to Asks", type: :feature do 
	before  do
		@john = FactoryGirl.create(:user) 
		@ask = FactoryGirl.create(:ask, user: @john)
		5.times{|n| FactoryGirl.create(:answer, user: @john, ask: @ask)}

	end
	scenario "permits a signed in user to write a review" , js:true do
	   	login_as(@john)

	    visit "/asks"
	    click_link @ask.question
	    puts @ask.answers.count

		fill_in 'answer[body]', with: "An amazing article"
		click_button "Post Answer"
		
	    puts '------------'
	    @ask.answers.each{|n| puts n.body}
	    puts @ask.answers.count
	    puts '--------------'
	 
	  
	    expect(page).to have_content("An amazing article")
	    
	end
end