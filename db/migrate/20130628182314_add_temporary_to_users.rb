class AddTemporaryToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :temporary, :boolean, default: false
  end
end
