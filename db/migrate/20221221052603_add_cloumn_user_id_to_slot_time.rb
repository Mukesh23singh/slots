class AddCloumnUserIdToSlotTime < ActiveRecord::Migration[6.0]
  def change
    add_column :slot_times, :user_id, :integer
  end
end
