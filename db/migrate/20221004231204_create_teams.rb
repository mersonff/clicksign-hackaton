class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:teams)
      create_table :teams do |t|
        t.string :name
        t.string :description

        t.timestamps
      end
    end
  end
end
