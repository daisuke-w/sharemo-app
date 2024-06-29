Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  resources :notes, only: [:new, :create]
end
