Rails.application.routes.draw do
  
  get 'events/today', to: 'events#today'
  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
