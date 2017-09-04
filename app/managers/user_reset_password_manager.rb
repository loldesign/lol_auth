class UserResetPasswordManager
	def initialize(options={})
		@user   = options[:user]
		@params = options[:params]
	end

	def send_instructions
		@user.send_reset_password_instructions if @user.present?

		true
	end

	def process
		return false unless valid_params?

		@user.update_attributes(password: @params[:password])
	end

	private
	def valid_params?
		(@params[:password].present? && @params[:password_confirmation].present?) &&
		 @params[:password] == @params[:password_confirmation]
	end
end
