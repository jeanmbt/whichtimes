Rails.application.routes.draw do
  get 'openings/edit'
  get 'openings/update'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'companies#index' 
  resources :companies, only: %i[ index show ]

  Rails.application.routes.draw do
    # [...]
    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :restaurants, only: [ :index ]
      end
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
