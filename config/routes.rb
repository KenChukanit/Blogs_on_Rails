Rails.application.routes.draw do
  
  root "posts#index"
  resources :posts do
    resources :comments
  end

  resources :users, only: [:new, :create, :edit, :update, :destroy] do
    get("change_password", to: "users#change_password")
    post('do_reset_password', to: "users#do_change_password")
    resource :passwords
  end

  resource :session, only: [:new, :create, :destroy]
  
end
