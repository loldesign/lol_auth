module Facebook
  class Login < Base
    attr_accessor :auth_header

    def initialize(options={})
      super()

      @user_type = options[:user_type] || 'User'
    end

    def login_with_token(token)
      return false if @user_type.constantize.where(email: @info['email']).where.not(provider: :facebook).count > 0

      @graph = Koala::Facebook::API.new(token)

      get_info()

      sign_in(@info['id'])
    end

    private
    def get_info
      @info  ||= @graph.get_object("me", {fields: 'picture, email, first_name, last_name, birthday'})
    end

    def sign_in(id)
      user = @user_type.constantize.find_or_create_by(uid: id) do |user|
        user.email             = build_email()
        user.password          = build_pasword()
        user.name              = build_name()
        user.remote_avatar_url = build_image()
        user.provider          = :facebook
      end

      build_token(user)

      user.reload
    end

    def build_email
      @info['email'] || "#{@info['first_name'].downcase.underscore}#{@info['last_name'].downcase.underscore}@sample.com"
    end

    def build_pasword
      Devise.friendly_token[0,20]
    end

    def build_name
      "#{@info['first_name']} #{@info['last_name']}"
    end

    def build_image
      "https://graph.facebook.com/#{@info['id']}/picture?type=large"
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
