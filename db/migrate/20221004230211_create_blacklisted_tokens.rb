class CreateBlacklistedTokens < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:blacklisted_tokens)
      create_table :blacklisted_tokens do |t|
        t.string :token
        t.references :user, null: false, foreign_key: true
        t.datetime :expire_at

        t.timestamps
      end
    end
  end
end
