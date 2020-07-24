class CreateCovidApiData < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_api_data do |t|
      t.json :payload

      t.timestamps
    end
  end
end
