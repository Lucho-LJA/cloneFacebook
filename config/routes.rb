Rails.application.routes.draw do
  root "boards#index"
  devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: 'users/omniauth_callbacks'}
  
  resources :boards, only: %i[index show edit] do
    resources :friendships, only: %i[create] do
      collection do
        get 'accept_friend'
        get 'decline_friend'
      end
    end
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
  
end
