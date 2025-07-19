class AddIntroToLevels < ActiveRecord::Migration[4.2]
  def change
    add_column :levels, :intro, :text
  end
end
