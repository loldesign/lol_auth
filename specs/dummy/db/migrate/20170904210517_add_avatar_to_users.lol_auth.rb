# This migration comes from lol_auth (originally 20170828174614)
class AddAvatarToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar, :string
  end
end
