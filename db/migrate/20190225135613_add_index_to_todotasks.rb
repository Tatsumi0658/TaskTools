class AddIndexToTodotasks < ActiveRecord::Migration[5.2]
  def change
    add_index :todotasks, :name
  end
end
