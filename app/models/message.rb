class Message < ApplicationRecord
  scope :unviewed, -> { where(viewed: false) }
end