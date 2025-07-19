class CreateLevelsUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :levels_users do |t|
      t.references :user, index: true
      t.references :level, index: true
      t.string :timestamps
    end
  end
end
