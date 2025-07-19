class CreateCommandsUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :commands_users do |t|
      t.references :user, index: true
      t.references :command, index: true
    end
  end
end
