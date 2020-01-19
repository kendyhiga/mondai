Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :questions, except: [:new] do
    resources :answers, except: [:new, :show]  do
      get 'set_as_right'
    end
    resources :topics, only: [:destroy]
    get 'publish', to: 'questions#toggle_publication'
  end

  resources :topics, only: [:index, :new, :create]

  get 'take_quiz', to: 'quiz#take'
  post 'result_quiz', to: 'quiz#result'
end
