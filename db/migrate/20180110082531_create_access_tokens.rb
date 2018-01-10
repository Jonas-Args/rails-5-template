class CreateAccessTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :access_tokens do |t|
      t.string   "token"
      t.timestamps
    end
    add_reference :access_tokens, :user, index: true, foreign_key: true, null: false, on_delete: :cascade
  end
end
