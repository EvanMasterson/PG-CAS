class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :auth0_user_id, :string
    add_column :users, :country, :string
    add_column :users, :pre_existing_conditions, :string
    add_column :users, :profile_photo_url, :string
  end
end
