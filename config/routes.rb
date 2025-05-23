Rails.application.routes.draw do

  authenticate :user, lambda { |u| u.admin? } do
    # mount Sidekiq::Web => '/sidekiq'
    namespace :admin do
      resources :users
      resources :submissions
      root to: 'users#index'
    end
  end

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

  resource :pricing
  resources :checkouts
  resources :premium_subscriptions
  get "success", to: "checkouts#success"
  resources :webhooks, only: :create
  resources :billings, only: :create

  root 'submissions#index'
end
