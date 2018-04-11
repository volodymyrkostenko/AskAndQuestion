require 'rails_helper'


RSpec.describe AsksController, type: :controller do 
 
  
  describe "GET index" do 
  	
  	it 'assigns asks' do 
      create_user_and_ask
      get :index
      expect(assigns(:asks)).to eq([@ask])
  	end

    it "renders the index template" do
      create_user
      get :index
      expect(response).to render_template("index")
    end
    it "renders the index template" do
      
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

  end

  describe "new" do   
        context "user signed in" do
          before(:each) do 
             create_user
            end    
      it "access to new" do
        get :new
        expect(response).to render_template('new')
      end
    end
     context "user signed out" do
      it "accees to new" do 
        get :new
        expect(response).to redirect_to (new_user_session_path)
      end
    end
  end

 describe "create" do 
    context "user signed in" do
            before(:each) do 
              create_user_and_ask
            end    
      it "redirect to ask" do
        @ask=nil
        post :create, params: {ask: {question: "Something"}}
        expect(response).to render_template(@ask)
      end 
      it "render to new validates fail" do
        
        @ask.question = nil  
        post :create, params: {ask: @ask.attributes}
        expect(response).to render_template('new')
      end
      it "sign value" do
        
        post :create, params: {ask: @ask.attributes}
        expect(assigns(:ask).question).to match(@ask.question)
      end
    end
    context "user signed out" do 
      it "redirect to sign in user" do
        post :create, params: {ask:{question: "lalalal"}}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
describe "Get show" do 
  context 'withou sign in' do 
    it "redirect to sign in user" do 
      create_user_and_ask_sign_out
      get :show, params: {id: @ask.id}
      expect(response).to redirect_to(new_user_session_path)
    end

  end
  context 'user sign in' do
    it "render show template" do 
      create_user_and_ask
      get :show, params: {id: @ask.id}
      expect(response).to be_success
    end


  end


end
describe "edit" do   
        context "user signed in" do
      it "access to edit" do
        create_user_and_ask
        get :edit, params: {id: @ask.id}
        expect(response).to render_template('edit')
      end
    end
     context "user signed out" do

      it "accees to new" do 
        create_user_and_ask_sign_out
        get :edit, params: {id: @ask.id}
        expect(response).to redirect_to (new_user_session_path)
      end
    end
end

describe "PUT update" do

  context "user signed in" do
      before(:each) do 
        create_user_and_ask
      end    
      it "redirect to ask" do
        ask=@ask
        @ask=nil
        put :update, params: { id: ask.id,  ask: {question: "Something"}}
        expect(response).to render_template(@ask)
      end 
    
      it "sign value" do
        
        put :update, params: { id: @ask.id,  ask: {question: "Something"}}
        expect(assigns(:ask).question).to match("Something")
      end
    end
  context "user signed out" do 
    it "redirect to sign in user" do
      create_user_and_ask_sign_out
      put :update, params: { id: @ask.id,  ask: {question: "Something"}}
      expect(response).to redirect_to(new_user_session_path)
    end
  end


end

describe "destroy" do 
  it 'success destroy' do
    create_user_and_ask
    expect{delete :destroy, params: {id: @ask.id}}.to change{Ask.count}.by(-1)
    expect(response).to redirect_to(asks_path)
  end
  it 'user sign out try' do
    create_user_and_ask_sign_out
    expect{delete :destroy, params: {id: @ask.id}}.to change{Ask.count}.by(0)
    expect(response).to redirect_to(new_user_session_path)
  end

end

private 
  def create_user
    @user= FactoryGirl.create(:user)
    sign_in @user
  end
	def create_user_and_ask
    create_user
    @ask = FactoryGirl.create(:ask, user: @user)
  end
  def create_user_and_ask_sign_out
    create_user_and_ask
    sign_out @user
  end

end

