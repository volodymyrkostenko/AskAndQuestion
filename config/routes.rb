Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :asks do
  	resources :answers
  end
  root to: "asks#index"
  mount ActionCable.server => '/cable'
end
