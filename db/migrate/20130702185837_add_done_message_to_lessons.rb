class AddDoneMessageToLessons < ActiveRecord::Migration[4.2]
  def change
    add_column :lessons, :done_message, :text
  end
end
