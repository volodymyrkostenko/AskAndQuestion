class AsksController < ApplicationController
	before_action :redirect
	rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
	before_action :set_ask, only: [:edit, :show, :destroy, :update]
	def index
		if current_user
			@asks = current_user.asks
		elsif current_consultant
			@asks = current_consultant.asks
		end
				
		
	end
	def show
		@answers = @ask.answers
		
		@answer= Answer.new
		
	end

	def new
		@ask= Ask.new
	end
	def create
		@ask = current_user.asks.build(ask_params)
		respond_to do |format|
			if @ask.save
				format.html{redirect_to @ask, notice: "Question was create"}
			else
				format.html{render :new, notice: "Something is wrong"}
			end


		end
	end
	def edit
		
	end

	def update
		respond_to do |format|
			if @ask.update(ask_params)
				format.html{redirect_to @ask, notice: "Question was update"}
			else
				format.html{render :new, notice: "Something is wrong"}
			end


		end
	end
	def destroy
		@ask.destroy
		respond_to do |format|
			format.html{redirect_to asks_path, notice: "Your question was destroy"}
	
		end
	end
	protected

	def resource_not_found
      message = "The article you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
	end
	private
	def set_ask
		@ask=Ask.find(params[:id])
		
	end
	def ask_params
		params.require(:ask).permit(:question, :consultant_id)		
	end
	def redirect
		if current_user.nil? && current_consultant.nil?
			authenticate_user!
		end
	end
end