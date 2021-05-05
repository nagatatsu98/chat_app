Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit, :update] do
    member do
      get :password
      patch :update_password
    end
  end
  
  resources :groups, param: :token, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :subscribers, only: [:create, :destroy]
  resources :messages, only: [:create]
end
