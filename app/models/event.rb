class Event <  ApplicationRecord
  belongs_to :host, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: { maximum: 20 }
  validates :host_id, presence: true
end