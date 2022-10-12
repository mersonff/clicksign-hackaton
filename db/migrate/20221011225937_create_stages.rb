class CreateStages < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:stages)
      create_table :stages do |t|
        t.string :name

        t.timestamps
      end
    end
  end
end
