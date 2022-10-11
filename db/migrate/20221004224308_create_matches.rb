# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :home_team, null: false, foreign_key: true
      t.references :away_team, null: false, foreign_key: true
      t.integer :home_team_goals, default: 0
      t.integer :away_team_goals, default: 0
      t.time :start_at
      t.time :finished_at
      t.time :current_time
      t.references :stage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
