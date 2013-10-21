FoodService::Application.routes.draw do
  resources :requests

  get 'calendar/:year/:month' => 'home#calendar', :as => 'show_month'

  root :to => "home#calendar"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users


end