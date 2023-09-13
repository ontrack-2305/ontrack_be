class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :type
      t.boolean :mandatory
      t.datetime :event_date
      t.integer :frequency, default: 0
      t.integer :time_needed
      t.integer :user_id
      t.string :notes

      t.timestamps
    end
  end
end
