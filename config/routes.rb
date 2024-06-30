Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  resources :notes, only: [:index, :new, :create]
end
