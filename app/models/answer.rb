class Answer < ApplicationRecord
  belongs_to :ask
  belongs_to :user

  after_create_commit { AnswerBroadcastJob.perform_later(self) }
end
