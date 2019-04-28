class AddColumnToTodotask < ActiveRecord::Migration[5.2]
  def change
    add_column :todotasks, :read, :boolean, default: false
  end
end
