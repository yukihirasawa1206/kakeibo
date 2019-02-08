Rails.application.routes.draw do
	root to: 'static_page#top'
	get    'callback' => 'sessions#callback'
	get    'login'    => 'sessions#login'
	delete 'logout'   => 'sessions#logout'
end
