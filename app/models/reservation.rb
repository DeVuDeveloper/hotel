class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :calendar, through: :room, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_guests, numericality: {greater_than: 0}
  validates :total_price, numericality: {greater_than_or_equal_to: 0}
  validates :status, presence: true
  validate :end_date_is_after_start_date
  validate :dates_available, on: :create

  enum status: {
    pending: "Pending",
    confirmed: "Confirmed",
    cancelled: "Cancelled"
  }

  after_create_commit :schedule_reminder_email
  after_create_commit -> { broadcast_prepend_to "reservations", partial: "admin/dashboard/reservations/reservation", locals: {reservation: self}, target: "reservations" }

  def dates
    (start_date..end_date).to_a
  end

  def generate_token
    self.token ||= SecureRandom.hex(20)
  end

  def schedule_reminder_email
    SendReminderEmailJob.perform_at(2.days.from_now, self.id)
  end

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def dates_available
    if start_date.present? && end_date.present? && room&.calendar.present?
      conflicting_entries = room.calendar.calendar_entries.where(date: start_date..end_date, available: false)
      if conflicting_entries.any?
        conflicting_dates = conflicting_entries.pluck(:date)
        errors.add(:base, "The following dates are not available: #{conflicting_dates.join(", ")}")
      end
    end
  end
end
