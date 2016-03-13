Rails.application.routes.draw do

  resources :activities do
    get 'get_event_types' => 'events#get_event_types'
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
  get     'terms' => 'static_pages#terms'
  get     'privacy' => 'static_pages#privacy'
  get     'news'    => 'static_pages#news'
  get     'signup'  => 'users#new'
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  resources :users do
  #  get     'change_password' => 'users#change_password'
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
