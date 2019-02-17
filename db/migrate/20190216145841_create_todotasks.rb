class CreateTodotasks < ActiveRecord::Migration[5.2]
  def change
    create_table :todotasks do |t|
      t.string :name, null:false
      t.integer :status, null:false
      t.datetime :deadline, null:false
      t.integer :priority, null:false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :todotasks, :priority, unique:true
  end
end
