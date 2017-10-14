class Ticket < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :message, presence: true, length: { maximum: 140 }
end
