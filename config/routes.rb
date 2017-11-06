Rails.application.routes.draw do
  resources :entries, except: :destroy
  resources :assets, except: [:destroy, :index]
  resources :equities, except: [:destroy, :index]
  resources :liabilities, except: [:destroy, :index]
  resources :revenues, except: [:destroy, :index]
  resources :expenses, except: [:destroy, :index]
end
