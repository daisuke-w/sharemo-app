Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  resources :notes
  resources :prompts, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :searches, only: [] do
    collection do
      get 'tags'
    end
  end
end
