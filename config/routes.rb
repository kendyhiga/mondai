Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :questions, only: [:index, :new, :create, :show] do
    resources :answers
  end
end
