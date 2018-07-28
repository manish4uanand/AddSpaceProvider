class CreateSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :created_by
      t.integer :booked_by

      t.timestamps
    end
  end
end
