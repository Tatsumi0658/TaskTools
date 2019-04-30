class AddUploadfileToTodotask < ActiveRecord::Migration[5.2]
  def change
    add_column :todotasks, :uploadfile, :string
  end
end
