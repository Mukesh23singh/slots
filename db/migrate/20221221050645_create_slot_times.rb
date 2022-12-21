class CreateSlotTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :slot_times do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :capacity

      t.timestamps
    end
  end
end
