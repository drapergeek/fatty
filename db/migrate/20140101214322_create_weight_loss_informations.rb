class CreateWeightLossInformations < ActiveRecord::Migration
  def change
    create_table :weight_loss_informations do |t|
      t.float :percentage_lost
      t.belongs_to :user
      t.float :original_weight
      t.float :most_recent_weight
      t.date :weight_updated_on

      t.timestamps
    end
  end
end
