class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :body
      t.integer :user_id
      t.integer :status_code
      t.string :title
      t.string :content_type

      t.timestamps
    end
    add_index :responses, [:user_id, :created_at]
  end
end
