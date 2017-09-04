module LolAuth
  require 'devise_token_auth'

  class Engine < ::Rails::Engine
    require 'carrierwave'
    require 'fog'
    require 'mini_magick'
    require 'koala'
    require 'jbuilder'

    isolate_namespace LolAuth
  end
end
