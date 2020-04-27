Rails.application.routes.draw do
  resources :projects
  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :messages do
  	member do
      put "like", to:    "messages#upvote"
      put "dislike", to: "messages#downvote"
    end 
    collection do
      get 'profile'
    end
    resources :comments
  end
  resources :projects do
  	resources :tasks
  end

  resources :relationships, only: [:create, :destroy]

  root 'messages#index'
end
