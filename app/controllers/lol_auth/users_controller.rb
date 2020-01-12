require_dependency "lol_auth/application_controller"

module LolAuth
  class UsersController < ApplicationController
    skip_before_action :authenticate_api_v1_user!, only: [:facebook_signin, :apple_signin, :google_signin]

    def facebook_signin
  		@manager = Facebook::Login.new()

      @user = @manager.login_with_token(params[:token])

      if @user.present?
        sign_in(:user, @user, store: false, bypass: true)

    		response.headers.merge!(@manager.auth_header)

        render :success, status: 201
      else
        render :error, status: 422
      end
	  end

    def apple_signin
      @manager = Apple::Login.new(params)

      @user = @manager.process()

      if @user.present?
        sign_in(:user, @user, store: false, bypass: true)

        response.headers.merge!(@manager.auth_header)

        render :success, status: 201
      else
        render :error, status: 422
      end
    end

    def google_signin
      @manager = Google::Login.new(params)

      @user = @manager.process()

      if @user.present?
        sign_in(:user, @user, store: false, bypass: true)

        response.headers.merge!(@manager.auth_header)

        render :success, status: 201
      else
        render :error, status: 422
      end
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
