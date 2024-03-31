class ChangeSeedTypeIdInPlants < ActiveRecord::Migration[7.1]
  def change
    change_column_null :plants, :seed_type_id, true
  end
end
