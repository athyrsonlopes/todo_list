class AddParentIdColunmToTasks < ActiveRecord::Migration[8.1]
  def change
    add_reference :tasks, :parent, foreign_key: { to_table: :tasks }
  end
end
