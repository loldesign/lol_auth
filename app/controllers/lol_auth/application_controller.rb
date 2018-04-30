module LolAuth
  class ApplicationController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    protect_from_forgery with: :null_session

    before_action :authenticate_api_v1_user!

    ensure_security_headers # See more: https://github.com/twitter/secureheaders
  end
end
