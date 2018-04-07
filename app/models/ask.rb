class Ask < ApplicationRecord
	has_many :answers, dependent: :destroy
	belongs_to :users
end
