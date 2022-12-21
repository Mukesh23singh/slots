class SlotTime < ApplicationRecord
  belongs_to :user
  validates :capacity, numericality: true
  validates :capacity, :start_time, :end_time, presence: true
  validate :validate_start_time, :validate_end_time, on: :create

  def validate_start_time
    if !start_time.blank?
      errors[:base] << 'Start Date can not be in the past.' if start_time < Time.current
    end
  end

  def validate_end_time
    if !end_time.blank?
      errors[:base] << 'End time should not be lesser than start time' if end_time < start_time
    end
  end
end
