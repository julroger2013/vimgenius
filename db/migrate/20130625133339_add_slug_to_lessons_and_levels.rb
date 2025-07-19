class AddSlugToLessonsAndLevels < ActiveRecord::Migration[4.2]
  def change
    add_column :lessons, :slug, :string
    add_column :levels, :slug, :string
  end
end
