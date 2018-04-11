require "rails_helper"
RSpec.describe "Asks", type: :request do
	before do 
		@user = FactoryGirl.create(:user)
		@ask = FactoryGirl.create(:ask, user: @user)
	end


	describe 'GET /ask/:id/edit' do
		context 'with non-sgned in user' do
		before{get "/asks/#{@ask.id}/edit"}
			it 'redirects to the signin page' do
				expect(response.status).to eq 302
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "with signed in user as owner successfil edit" do 
			before do 
				login_as(@user)
				get "/asks/#{@ask.id}/edit"

			end
			it "successfully edit ask" do
				expect(response.status).to eq 200

			end
		end

	end

	describe 'GET /asks/:id' do
		context 'with existing asks' do
		before do 
			login_as(@user)
			get "/asks/#{@ask.id}"

		end
			 it "handles existing article" do
			 	expect(response.status).to eq 200

			 end
		end
		context 'with non-existing asks' do
			before do 
			login_as(@user)
			get "/asks/xxx"

		end

			it "handles non-existing asks" do 
				expect(response.status).to eq 302
			end
		end
	end



end