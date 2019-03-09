class AddLabelsRefToTodotasks < ActiveRecord::Migration[5.2]
  def change
    #add_reference :todotasks, :label, foreign_key: true
  end
end
