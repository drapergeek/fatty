class CreateFitbitInformations < ActiveRecord::Migration
  def change
    create_table :fitbit_informations do |t|
      t.belongs_to :user
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps
    end
  end
end
