class AnswersController < ApplicationController

	def create
		@answer = current_user.answers.build(answer_params)
	end

	private
	def answer_params
		params.require(:answer).permit(:body)
		
	end
end