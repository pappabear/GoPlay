Rails.application.routes.draw do

  resources :articles
  get     'news'    => 'articles#news'

  resources :feedback_emails
  get 'contact' => 'feedback_emails#new'
  post 'feedback_emails/create'

  resources :activities do
    get 'get_event_types' => 'events#get_event_types'
    resources :event_types
  end

  resources :venues
  get     'venues_search'   => 'venues#search'
  resources :events
  get     'events_search'   => 'events#search'

  get     'password_resets/new'
  get     'password_resets/edit'
  get     'account_activations/edit'
  get     'sessions/new'

  root                'static_pages#home'
  get     'help'    => 'static_pages#help'
  get     'about'   => 'static_pages#about'
  get     'terms' => 'static_pages#terms'
  get     'privacy' => 'static_pages#privacy'
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
