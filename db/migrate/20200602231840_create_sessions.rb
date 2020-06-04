class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string 'token'
      t.integer 'user_id'
      t.string 'cookies'

      t.timestamps
    end
    add_foreign_key :user_id
  end
end
