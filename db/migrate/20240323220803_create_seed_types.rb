class CreateSeedTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :seed_types do |t|
      t.string :seed_type
      t.text :description

      t.timestamps
    end
  end
end
