Rails.application.routes.draw do
  devise_for :users
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
  end
  resources :searches, only: [] do
    get 'tags', on: :collection
  end
end
