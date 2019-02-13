Rails.application.routes.draw do
  root to:  'static_page#top'
  get       'callback' => 'sessions#callback'
  post      'signin'    => 'sessions#signin'
  delete    'signout'   => 'sessions#signout'
  resources :account_books, only:[:index, :create, :destroy]
end
