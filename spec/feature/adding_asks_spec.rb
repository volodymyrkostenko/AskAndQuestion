require "rails_helper"

RSpec.feature "Creating Articles" do
  
  before do
    @john = FactoryGirl.create(:user)
    5.times{ FactoryGirl.create(:ask, user: @john)}
    login_as(@john)
  end
  
    scenario "A user creates a new article" do
      visit "/"
      
      click_link "create new question"
      
      fill_in "ask_question", with: "Creating a blog"
    
      
      click_button "Save changes"
      
     
      expect(page).to have_content("Creating a blog")
      puts "***************"
      @john.asks.each{|n| puts n.question}
      puts @john.asks.count
      puts "***********"

    
  end
  scenario "A user creates a new article" do
      visit "/"
      
      click_link "create new question"
      
      fill_in "ask_question", with: ""
    
      
      click_button "Save changes"
      
     
     expect(page.current_path).to eq(asks_path)
    
  end
end