module ApplicationHelper
	def login_helper style
		if current_user || current_consultant
			link_to "Sign Out", destroy_user_session_path, method: :delete, class: style
		else
			(link_to "Sign Up" , new_user_registration_path, class: style)+
			(link_to "Sign In" , new_user_session_path, class: style)
			
		end
	end
end
