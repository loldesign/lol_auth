class LolAuth::InstallGenerator < Rails::Generators::Base
  desc "Install LolAuth to your ptoject"

  source_root File.expand_path('../templates', __FILE__)

  def add_facebook_config
    application "config.facebook_app = config_for(:facebook_app)"
  end

  def copy_fcebook_file
    copy_file "facebook_app.yml", "config/facebook_app.yml"
  end

  def copy_migrations
    rake "lol_auth:install:migrations"
  end
end
