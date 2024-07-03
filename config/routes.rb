Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  resources :notes
  resources :prompts, only: [:new, :create, :show, :edit, :update, :destroy]
end
