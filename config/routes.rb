Rails.application.routes.draw do

  resources :activities do
    resources :event_types
  end
  resources :venues
  resources :events
  get     'search'   => 'events#search'

  get     'password_resets/new'
  get     'password_resets/edit'
  get     'account_activations/edit'
  get     'sessions/new'

  root                'static_pages#home'
  get     'help'    => 'static_pages#help'
  get     'about'   => 'static_pages#about'
  get     'contact' => 'static_pages#contact'
  get     'news'    => 'static_pages#news'
  get     'signup'  => 'users#new'
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  resources :users do
    get     'notifications' => 'users#notifications'
    get     'activities' => 'users#activities'
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
