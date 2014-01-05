class CreateDailyWeightInformations < ActiveRecord::Migration
  def change
    create_table :daily_weight_informations do |t|
      t.float :weight
      t.float :percentage_lost
      t.belongs_to :user

      t.timestamps
    end
  end
end
