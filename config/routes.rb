Rails.application.routes.draw do
  get 'profiles/show'
  resources :communities
  resources :submissions do
    member do
      put 'upvote', to: 'submissions#upvote'
      put 'downvote', to: 'submissions#downvote'
    end

    resources :comments do
      member do
        put 'upvote', to: 'comments#upvote'
        put 'downvote', to: 'comments#downvote'
      end
    end
  end
  devise_for :users
  resources :profiles, only: :show

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root 'submissions#index'
end
