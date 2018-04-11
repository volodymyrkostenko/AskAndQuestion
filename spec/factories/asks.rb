FactoryGirl.define do
  factory :ask do
    question {Faker::Lorem.sentence}
  end
end
