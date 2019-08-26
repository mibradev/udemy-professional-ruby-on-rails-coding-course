Rails.application.routes.draw do
  namespace :admin do
    resources :posts
    resources :users
    resources :employee_users
    resources :admin_users
    root to: "posts#index"
  end

  resources :audit_logs
  resources :posts
  devise_for :users
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
