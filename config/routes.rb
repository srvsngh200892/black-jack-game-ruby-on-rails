Blackjack::Application.routes.draw do

  resources :games ,:only => [] do
 		collection do
    	get 'setup'
			get 'play'
			get 'pull'
			get 'skip'
  	end
	end

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'

  resources :users ,:only => [:index, :new, :create] do
		collection do
      get 'stats'
			get 'logout'
		end
	end
	root :to => 'sessions#new'
end
