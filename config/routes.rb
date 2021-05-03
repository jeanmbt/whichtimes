Rails.application.routes.draw do



  get 'pages/dashboard'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'companies#index' 
  resources :companies  do
    resources :openings, except: %i[ new show index ]
    get 'mon', to: 'openings#mon', as: "mon"
    get 'tue', to: 'openings#tue', as: "tue"
    get 'wed', to: 'openings#wed', as: "wed"
    get 'thu', to: 'openings#thu', as: "thu"
    get 'fri', to: 'openings#fri', as: "fri"
    get 'sat', to: 'openings#sat', as: "sat"
    get 'sun', to: 'openings#sun', as: "sun"
    get 'review', to: 'companies#review', as: "review"
  end

  devise_for :users
  # [...]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :restaurants, only: [ :index ]
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
