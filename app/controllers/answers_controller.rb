class AnswersController < ApplicationController

	def create
		
		@answer = @ask.answers.build(answer_params)
	end

	private
	def comment_params
		params.require(:answer).permit(:body)
		
	end
end