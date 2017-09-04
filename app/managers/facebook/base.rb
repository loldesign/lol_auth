module Facebook
  class Base
    def initialize
      @app_id        = Rails.configuration.facebook_app['id']
      @app_secret_id = Rails.configuration.facebook_app['secret_key']
    end
  end
end

#How to use
# Facebook::Base
