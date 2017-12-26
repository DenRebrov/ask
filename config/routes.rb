Rails.application.routes.draw do

  root 'users#index'

  get 'questions_hashtags_page', to: 'questions#questions_hashtags_page'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]

  #get 'sign_up' => 'users#new'
  #get 'log_out' => 'sessions#destroy'
  #get 'log_in' => 'sessions#new'
end
