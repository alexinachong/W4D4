class CreateSessionTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :session_tokens do |t|
      t.string :token, null: false
      t.string :environment, null: false

      t.timestamps
    end

    add_index :session_tokens, :token, unique: true 
  end
end
