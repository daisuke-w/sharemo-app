Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root 'tops#index'

  resources :notes do
    resource :reference, only: [] do
      post 'increment_clicks', on: :member
    end
  end

  resources :prompts, only: [:new, :create, :show, :edit, :update, :destroy] do
    resource :reference, only: [] do
      post 'increment_clicks', on: :member
    end
    resources :notes, only: [:new, :create]
  end

  resources :searches, only: [] do
    collection do
      get 'tags'
      get 'results'
    end
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    member do
      get 'basic_info', to: 'users#basic_info'
      get 'notes_info', to: 'users#notes_info'
      get 'prompts_info', to: 'users#prompts_info'
    end
  end

  resources :administrators, only: [:index] do
    member do
      patch :update_owner
      delete :destroy_user
    end
  end
end
