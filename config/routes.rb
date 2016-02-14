Rails.application.routes.draw do

  get 'venues/index'

  get 'venues/show'

  get 'venues/new'

  get 'venues/edit'

  get 'venues/create'

  get 'venues/update'

  get 'venues/destroy'

  get 'venue/index'

  get 'venue/show'

  get 'venue/new'

  get 'venue/edit'

  get 'venue/create'

  get 'venue/update'

  get 'venue/destroy'

  resources :activities do
    resources :event_types
  end

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'account_activations/edit'
  get 'sessions/new'

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'news'    => 'static_pages#news'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
