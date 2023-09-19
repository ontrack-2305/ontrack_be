class AddSkippedToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :skipped, :boolean, default: false
  end
end
