require 'rails_helper'

RSpec.describe Ask, type: :model do
	it "check belongs to user" do
		should belong_to (:user)
	end
	it "check has many answers" do 
		should have_many(:answers)
	end
	describe '#question' do
		it { should validate_presence_of(:question) }
    end
end
