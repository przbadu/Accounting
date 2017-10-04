Rails.application.routes.draw do
  resources :entries, except: :destroy
  resources :assets, except: [:destroy, :index]
  resources :equities, except: [:destroy, :index]
end
