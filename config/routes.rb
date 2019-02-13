Rails.application.routes.draw do
  namespace :api do
    resources :teachers, :except => [:new, :edit]
    resources :students, :except => [:new, :edit]
    
    post '/register', to: 'teachers#register'
    get '/commonstudents', to: 'teachers#commonstudents'
    post '/suspend', to: 'teachers#suspend'
    post '/retrievefornotifications', to: 'teachers#retrievefornotifications'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
