class Ask < ApplicationRecord
	has_many :answers, dependent: :destroy
	belongs_to :user
	validates :question, presence: true
end
