class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :dispname
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
