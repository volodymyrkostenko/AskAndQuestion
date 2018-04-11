require 'rails_helper'

RSpec.describe User, type: :model do
  it "check has many answers" do 
		should have_many(:answers)
  end

  it "check has many asks" do 
		should have_many(:asks)
  end
end
