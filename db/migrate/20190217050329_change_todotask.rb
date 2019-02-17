class ChangeTodotask < ActiveRecord::Migration[5.2]
  def up
    remove_index :todotasks, :priority
    add_index :todotasks, :priority
    add_column :todotasks, :content, :text
  end

  def down
    remove_index :todotasks, :priority
    add_index :todotasks, :priority, unique:true
    remove_column :todotasks, :content
  end
end
