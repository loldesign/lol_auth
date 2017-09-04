require_dependency "lol_auth/application_controller"

module LolAuth
  class UsersController < ApplicationController
    def facebook_signin
  		@manager = Facebook::Login.new()

      @user = @manager.login_with_token(params[:token])

      sign_in(:user, @user, store: false, bypass: true)

  		response.headers.merge!(@manager.auth_header)

      render :success, status: 201
	 end
  end
end
