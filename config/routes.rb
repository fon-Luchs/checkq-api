Rails.application.routes.draw do
  namespace :api do
    resources :subjects, only: :index

    resource :profile, only: :create

    resource :session, only: [:create, :destroy]
  end

  resource :specifications, only: :show
end
