class AddDirectionsToLessons < ActiveRecord::Migration[4.2]
  def change
    add_column :lessons, :directions, :text
  end
end
