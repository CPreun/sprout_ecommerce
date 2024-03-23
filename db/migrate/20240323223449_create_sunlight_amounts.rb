class CreateSunlightAmounts < ActiveRecord::Migration[7.1]
  def change
    create_table :sunlight_amounts do |t|
      t.string :amount

      t.timestamps
    end
  end
end
