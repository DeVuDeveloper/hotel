class ReservationConfirmationJob < SidekiqJob

    def perform(reservation_id)
      @reservation = Reservation.find(reservation_id)
      ReservationMailer.confirmation_email(@reservation).deliver_now
    end
  end
