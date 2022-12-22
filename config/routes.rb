Rails.application.routes.draw do
  resources :slot_times
  get 'users/:name', to: 'users#show'
  post 'users/create_slots', to: 'users#create_slots', format: 'json'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
