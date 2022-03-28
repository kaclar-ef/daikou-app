class DrivingRequest < ApplicationRecord
  belongs_to :user
  
  validates :reservation_datetime, :departure_place, :destination, :car_model, :status, :receipt_id, presence: true

  # 依頼日時が未来であることを検証
  validate :reservation_datetime_cannot_be_in_the_past

  validates :departure_place, :destination, length: { maximum: 255 }

  validates :car_model, inclusion: { in: %w(普通(AT) 普通(MT) 中型 大型) }
  validates :status, inclusion: { in: %w(代行依頼中 代行受領済 依頼完了済) }

  validates :receipt_id, format: { with: /\A[a-zA-Z\d]{6}\z/ }

  def reservation_datetime_cannot_be_in_the_past
    if reservation_datetime.present? && reservation_datetime < Time.current
      errors.add(:reservation_datetime, 'は未来の日時を設定してください')
    end
  end
end
