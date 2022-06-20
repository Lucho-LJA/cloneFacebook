Rails.application.routes.draw do
  root "boards#index"
  devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: 'users/omniauth_callbacks'}
  
  resources :boards, only: %i[index show] do
    resources :friendships, only: %i[create]
    resources :likes, only: %i[create]
  end
  resources :posts, only: %i[index new create show destroy] do
    resources :likes, only: %i[create]
  end
  resources :comments, only: %i[new create destroy] do
    resources :likes, only: %i[create]
  end

  get 'boards/index'
  get 'boards/show'
  get 'boards/edit'
  
end
