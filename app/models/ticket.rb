class Ticket < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :category, presence: true, on: [:sales, :technical]
  validates :title, presence: true, length: { maximum: 100 }
  validates :status, presence: true
  validates :message, presence: true, length: { maximum: 150 }
end
