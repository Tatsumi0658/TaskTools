class AddIndexToTodotasks < ActiveRecord::Migration[5.2]
  def change
    add_index :todotasks, :name
    add_index :todotasks, :user_id
  end
end
