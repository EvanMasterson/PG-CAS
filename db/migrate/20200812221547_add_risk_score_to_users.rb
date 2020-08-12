class AddRiskScoreToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :risk_score, :integer
  end
end
