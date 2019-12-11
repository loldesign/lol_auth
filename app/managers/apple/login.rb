module Apple
  class Login
    attr_accessor :auth_header

    def initialize(options={})
      @info = options[:resource]

      @user_type = options[:user_type] || 'User'
    end

    def process
      user = @user_type.constantize.find_or_create_by(uid: @info['email']) do |user|
               user.email    = @info['email']
               user.password = build_pasword()
               user.name     = @info['name']
               user.provider = :apple
             end

      build_token(user)

      user.reload
    end

    private
    def build_pasword
      Devise.friendly_token[0,20]
    end

    def build_token(user)
      client_id = SecureRandom.urlsafe_base64(nil, false)
      token     = SecureRandom.urlsafe_base64(nil, false)

      user.tokens[client_id] = {
        token: BCrypt::Password.create(token),
        expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
      }

      user.save

      @auth_header = user.create_new_auth_token(client_id)
    end
  end
end