class AddCompletedToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :completed, :datetime
  end
end
