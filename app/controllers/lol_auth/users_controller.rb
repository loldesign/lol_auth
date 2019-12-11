require_dependency "lol_auth/application_controller"

module LolAuth
  class UsersController < ApplicationController
    skip_before_action :authenticate_api_v1_user!, only: [:facebook_signin]

    def facebook_signin
  		@manager = Facebook::Login.new()

      @user = @manager.login_with_token(params[:token])

      sign_in(:user, @user, store: false, bypass: true)

  		response.headers.merge!(@manager.auth_header)

      render :success, status: 201
	  end

    def apple_signin
      @manager = Apple::Login.new()

      @user = @manager.process(params[:resource])

      sign_in(:user, @user, store: false, bypass: true)

      response.headers.merge!(@manager.auth_header)

      render :success, status: 201
    end
  end

  def update_avatar
    @user = current_user
    @user.avatar = avatar_params[:avatar]

    if @user.save
      UserStateManager.new(user: @user).process

      render :success, status: 201
    else
      render :fail, status: 422
    end
  end
end
