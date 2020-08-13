class AddBearerTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bearer_token, :string
  end
end
