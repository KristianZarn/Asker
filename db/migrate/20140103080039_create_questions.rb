class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.integer :votes, default: 0
      t.integer :user_id

      t.timestamps
    end
    add_index :questions, [:user_id, :created_at]
  end
end
