class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:users)
      create_table :users do |t|
        t.string :name
        t.string :email
        t.string :password_digest
        t.datetime :token_issued_at

        t.timestamps
      end
      add_index :users, :email, unique: true
    end
  end
end
