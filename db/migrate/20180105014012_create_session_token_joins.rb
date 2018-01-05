class CreateSessionTokenJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :session_token_joins do |t|
      t.integer :user_id, null: false
      t.integer :session_id, null: false
      t.timestamps
    end

    add_index :session_token_joins, :user_id
    add_index :session_token_joins, :session_id, unique: true 
  end
end
