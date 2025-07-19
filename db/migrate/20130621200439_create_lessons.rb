class CreateLessons < ActiveRecord::Migration[4.2]
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :summary
    end
  end
end
