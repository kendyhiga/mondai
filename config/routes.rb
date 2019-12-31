Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :questions do
    resources :answers do
      get 'set_as_right'
    end
  end

  resources :topics

  get 'take_quiz', to: 'quiz#take'
  post 'result_quiz', to: 'quiz#result'
end
