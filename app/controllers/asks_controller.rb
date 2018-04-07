class AsksController < ApplicationController
	
	before_action :set_ask, only: [:edit, :show, :destroy, :update]
	def index
		@asks = Ask.all
		
	end
	def show
		@answers = @ask.answers
		@answer= Answer.new
	end

	def new
		@ask= Ask.new
	end
	def create
		@ask = Ask.new(ask_params)
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
	private
	def set_ask
		@ask=Ask.find(params[:id])
		
	end
	def ask_params
		params.require(:ask).permit(:question)		
	end
end