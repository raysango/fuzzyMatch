Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'insurance_webhooks#index'
  resources :insurance_webhooks do
    put :match, on: :collection
  end
end
