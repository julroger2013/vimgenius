class CreateLevels < ActiveRecord::Migration[4.2]
  def change
    create_table :levels do |t|
      t.references :lesson, index: true
      t.integer :sequence_number
      t.string :name
    end
  end
end
