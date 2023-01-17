Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, path: "auth", path_names: { sign_in: :login, sign_out: :logout, sign_up: :register }

  resources :rooms, only: [:index]
end
