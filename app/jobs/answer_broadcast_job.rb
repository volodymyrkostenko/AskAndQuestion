class AnswerBroadcastJob < ApplicationJob
  queue_as :default

  def perform(answer)
    ActionCable.server.broadcast "asks_#{answer.ask.id}_channel", answer: render_answer(answer)
  end

  private

  def render_answer(answer)
    AnswersController.render partial: 'answers/answer', locals: { answer: answer }
  end
end 