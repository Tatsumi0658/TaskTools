class CreateTaskfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :taskfiles do |t|
      t.string :uploadfiles
      t.references :todotask, foreign_key: true

      t.timestamps
    end
  end
end
