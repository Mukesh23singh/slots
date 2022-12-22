class User < ApplicationRecord
  has_many :slot_times
  validates_presence_of :name
end
