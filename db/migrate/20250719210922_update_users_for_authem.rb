class UpdateUsersForAuthem < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :reset_password_token, :password_reset_token
  end
end
