class Ticket < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :message, presence: true, length: { maximum: 140 }
end
