class AsksController < ApplicationController
	before_action :redirect_to_sign_in
	rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
	before_action :set_ask, only: [:edit, :show, :destroy, :update]
	def index
		if current_user
			@asks = current_user.asks
		else	
			@asks = current_consultant.asks
		end
		
	end
	def show
		validate_current('see') do
			@answers = @ask.answers	
			@answer= Answer.new
		end
		
	end

	def new 
		check_users {@ask= Ask.new}
	end
	def create
		check_users do
			@ask = current_user.asks.build(ask_params)
			respond_to do |format|
				if @ask.save
					format.html{redirect_to @ask, notice: "Question was create"}
				else
					format.html{render :new, notice: "Something is wrong"}
				end
			end
			
		end
	end
	def edit
		validate_current('edit')
	end

	def update
		validate_current ('update') do
			respond_to do |format|
				if @ask.update(ask_params)
					format.html{redirect_to @ask, notice: "Question was update"}
				else
					format.html{render :new, notice: "Something is wrong"}
				end
			end

		end
	end
		
		
	end
	def destroy
		validate_current do
			@ask.destroy
			respond_to do |format|
			format.html{redirect_to asks_path, notice: "Your question was destroy"}
	
		end
		end
		
	end

	
	private
	def set_ask
		@ask=Ask.find(params[:id])
		
	end
	def ask_params
		params.require(:ask).permit(:question, :consultant_id)		
	end
	def redirect_to_sign_in
		unless current_consultant || current_user
			authenticate_user! 
		end
		
	end
	def validate_current(action)
		if current_user == @ask.user 
			yield unless action == 'edit'
		elsif action == "see" && current_consultant == @ask.consultant && current_consultant != nil

			yield
		else
			respond_to do |format|
				format.html{redirect_to root_path, notice: "You can't #{action} asks other users"}
			end

		end
	end

	def check_users
		if current_user
			yield
		else
			flash[:alert] = "Consultants can't create asks"
			redirect_to root_path 
			
		end
	end
	def resource_not_found
      message = "The article you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
	end