Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # API routes
  namespace :api do
    namespace :v1 do
      resources :entries, except: :destroy
      resources :assets, except: [:destroy, :index]
      resources :equities, except: [:destroy, :index]
      resources :liabilities, except: [:destroy, :index]
      resources :revenues, except: [:destroy, :index]
      resources :expenses, except: [:destroy, :index]
    end
  end
end
