class AnswersController < ApplicationController

	def create
		@ask = Ask.find(params[:ask_id])
		@answer = current_user.answers.build(answer_params)
		@answer.consultant = @ask.consultant
		byebug
		

	end

	private
	def answer_params
		params.require(:answer).permit(:body)
		
	end
end