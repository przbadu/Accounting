Rails.application.routes.draw do
  resources :entries, except: :destroy
  resources :assets, except: [:destroy, :index]
  resources :liabilities, except: [:destroy, :index]
end
