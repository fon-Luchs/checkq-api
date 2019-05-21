Rails.application.routes.draw do
  namespace :api do
    resources :subjects, only: :index
  end

  resource :specifications, only: :show
end
