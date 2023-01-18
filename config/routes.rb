Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, path: "auth", path_names: { sign_in: :login, sign_out: :logout, sign_up: :register }, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :rooms, only: %i[index create show] do
    resources :messages, only: [:create]
  end

  resources :users, only: [:show]
end
