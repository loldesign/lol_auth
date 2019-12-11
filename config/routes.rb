Rails.application.routes.draw do
	root 'home#index'
	# RESET PASSWORD
	get '/passwords/new'     , to: 'lol_auth/passwords#new'     , as: :new_password
	post '/passwords/create' , to: 'lol_auth/passwords#create'  , as: :create_password
	get '/passwords/complete', to: 'lol_auth/passwords#complete', as: :complete_password

	namespace :api do
		namespace :v1 do
			mount_devise_token_auth_for 'User', at: 'auth'

			# USER SIGNUP FACEBOOK
			post '/users/facebook/signin', to: '/lol_auth/users#facebook_signin'
			# USER SIGNUP APPLE
			post '/users/apple/signin'   , to: '/lol_auth/users#apple_signin'
		end
	end
end
