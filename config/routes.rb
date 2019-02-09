Rails.application.routes.draw do
	root to:  'static_page#top'
	get       'callback' => 'sessions#callback'
	post      'login'    => 'sessions#login'
	delete    'logout'   => 'sessions#logout'
	resources :account_books, only:[:index, :create, :destroy]
end
