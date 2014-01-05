class CreateOriginalWeightInformations < ActiveRecord::Migration
  def change
    create_table :original_weight_informations do |t|
      t.float :weight
      t.belongs_to :user

      t.timestamps
    end
  end
end
