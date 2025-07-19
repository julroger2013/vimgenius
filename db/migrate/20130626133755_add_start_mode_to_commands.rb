class AddStartModeToCommands < ActiveRecord::Migration[4.2]
  def change
    add_column :commands, :start_mode, :string
  end
end
