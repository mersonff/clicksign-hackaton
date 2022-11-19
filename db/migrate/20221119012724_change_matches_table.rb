class ChangeMatchesTable < ActiveRecord::Migration[7.0]
  def up
    remove_column(:matches, :current_time)

    remove_column(:matches, :start_at)
    remove_column(:matches, :finished_at)

    add_column(:matches, :start_at, :datetime)
    add_column(:matches, :finished_at, :datetime)
  end

  def down
    add_column(:matches, :current_time, :time)

    remove_column(:matches, :start_at)
    remove_column(:matches, :finished_at)

    add_column(:matches, :start_at, :time)
    add_column(:matches, :finished_at, :time)
  end
end
