Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :questions, only: [:index, :new, :create, :show, :edit, :update] do
    resources :answers do
      get 'set_as_right'
    end
  end

  get 'take_quizz', to: 'quizz#take'
  post 'result_quizz', to: 'quizz#result'
end
