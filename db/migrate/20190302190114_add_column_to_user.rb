class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin_flag, :boolean, default: false
  end
end
