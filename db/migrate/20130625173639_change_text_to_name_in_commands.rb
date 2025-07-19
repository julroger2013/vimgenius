class ChangeTextToNameInCommands < ActiveRecord::Migration[4.2]
  def change
    rename_column :commands, :text, :name
  end
end
