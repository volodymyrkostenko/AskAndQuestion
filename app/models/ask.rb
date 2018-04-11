class Ask < ApplicationRecord
	has_many :answers, dependent: :destroy
	belongs_to :user
	belongs_to :consultant
	validates :question, presence: true
end
