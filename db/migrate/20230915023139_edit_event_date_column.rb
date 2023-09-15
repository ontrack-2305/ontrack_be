class EditEventDateColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :event_date, :string
  end
end
