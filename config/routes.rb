Rails.application.routes.draw do
  get 'pages/home'

  devise_for :consultants
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :asks do
  	resources :answers
  end
 
 authenticated :user do
    root 'asks#index'
 end
 authenticated :consultant do
    root 'asks#index'
 end


  root "pages#home"

  mount ActionCable.server => '/cable'
end
