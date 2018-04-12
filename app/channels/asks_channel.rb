class AsksChannel < ApplicationCable::Channel
  def subscribed
  	    stream_from "asks_#{params['ask_id']}_channel"
  end

  def unsubscribed
  end

  def send_answer(data)
  	if current_user
   		current_user.answers.create!(body: data['answer'], ask_id: data['ask_id'])
   	else
   		current_consultant.answers.create!(body: data['answer'], ask_id: data['ask_id'])
   	end
   
  end
end 