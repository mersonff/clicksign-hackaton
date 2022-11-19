class AddIndexesOnUniqueness < ActiveRecord::Migration[7.0]
  def change
    add_index(:teams, :name, unique: true)
    add_index(:stages, :name, unique: true)
  end
end
