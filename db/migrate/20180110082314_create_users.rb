class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :encrypted_password
      t.boolean :is_active, default: true
      t.boolean :is_locked, default: false
      t.attachment :profile_photo
      t.string   :reset_password_token
      t.datetime :reset_password_token_sent_at
      t.timestamps
    end
  end
end
