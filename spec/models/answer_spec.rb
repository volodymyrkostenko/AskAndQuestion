require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "check belongs to user" do
		should belong_to (:user)
  end
  it "check belongs to user" do
		should belong_to (:ask)
  end
  it "check presence answer" do
  	should validate_presence_of(:body)

  end
end
