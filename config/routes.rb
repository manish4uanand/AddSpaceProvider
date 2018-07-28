Rails.application.routes.draw do
  
	
  get "slots/book_slot", to: "slots#book_slot"  
  resources :slots do
    resources :bids
  end
  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
	  get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'slots#index'

end
