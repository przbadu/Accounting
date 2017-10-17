Rails.application.routes.draw do

  # API routes
  namespace :api do
    namespace :v1 do
      resources :entries, except: :destroy
      resources :assets, except: [:destroy, :index]
      resources :equities, except: [:destroy, :index]
      resources :liabilities, except: [:destroy, :index]
      resources :revenues, except: [:destroy, :index]
    end
  end
end
