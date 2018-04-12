class AnswersController < ApplicationController

	def create
		if current_user
			@answer = current_user.answers.build(answer_params)
		elsif current_consultant
			@answer = current_consultant.answers.build(answer_params)
					  
		end	
	end

	private
	def answer_params
		params.require(:answer).permit(:body)
		
	end
end