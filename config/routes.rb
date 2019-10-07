Rails.application.routes.draw do
  
  resources :matches
  resources :players
  
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "callbacks"}
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  scope '/api' do
    post '/ping/matches', to: 'api#pingMatch'
  end

  root to: "home#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
