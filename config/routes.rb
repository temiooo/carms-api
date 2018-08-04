Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index', via: :all

  scope module: :v1, path: 'api/v1' do
    post 'auth/create', to: 'users#create'
    post 'auth/login', to: 'users#login'
    post 'auth/password/forgot', to: 'passwords#forgot'
    post 'auth/password/reset', to: 'passwords#reset'
  end

  match '*path', to: 'errors#unknown_route', via: :all
  
end
