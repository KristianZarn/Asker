class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :votes, default: 0
      t.boolean :selected, default: false
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
    add_index :answers, :user_id
    add_index :answers, :question_id
  end
end
