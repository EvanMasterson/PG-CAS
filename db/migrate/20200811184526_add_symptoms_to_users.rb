class AddSymptomsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :has_symptoms, :boolean
    add_column :users, :age, :integer
  end
end
