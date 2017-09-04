require_dependency "lol_auth/application_controller"

module LolAuth
  class PasswordsController < ApplicationController
    include Rails.application.routes.url_helpers

  	before_action :load_user, except: [:complete_password]

  	def new
  		@user = nil unless @user.persisted?
  	end

  	def create
  		@manager = UserResetPasswordManager.new(user: @user, params: params[:user])

  		if @manager.process
  			redirect_to complete_password_path
  		else
  			redirect_to new_password_path(token: params[:token], notice: 'Confirmação deve ser igual a Senha e maior de 8 caracteres')
  		end
  	end

  	def complete_password
  	end

  	private
  	def load_user
  		@user = User.reset_password_by_token({reset_password_token: params[:token]})
  	end
  end
end
