Rails.application.routes.draw do
  resources :communities do
    resources :subscriptions
  end

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

  get "submissions/unsubscribe/:unsubscribe_hash" => "submissions#unsubscribe", as: :comment_unsubscribe

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get :search, controller: :application
  root 'submissions#index'
end
