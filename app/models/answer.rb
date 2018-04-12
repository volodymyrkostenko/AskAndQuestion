class Answer < ApplicationRecord
  belongs_to :ask
  belongs_to :user, optional: true	
  belongs_to :consultant, optional: true

  validates :body, presence: true

  after_create_commit { AnswerBroadcastJob.perform_later(self) }
end
