$(document).ready(function() {
  const startDateInput = $('#reservation_start_date');
  const endDateInput = $('#reservation_end_date');
  const guestsInput = $('#reservation_number_of_guests');
  const totalPriceElement = $('#total-price');
  const pricePerNight = parseFloat($('#price').text());

  function updateTotalPrice() {
    const startDate = new Date(startDateInput.val());
    const endDate = new Date(endDateInput.val());
    const numberOfGuests = guestsInput.val();
    const totalPrice = calculateTotalPrice(startDate, endDate, numberOfGuests, pricePerNight);

    totalPriceElement.text(`$ ${totalPrice}`);
  }

  startDateInput.change(updateTotalPrice);
  endDateInput.change(updateTotalPrice);
  guestsInput.on('input', updateTotalPrice);

  updateTotalPrice();
});

function calculateTotalPrice(startDate, endDate, numberOfGuests, pricePerNight) {
  const oneDay = 24 * 60 * 60 * 1000;

  const startTimestamp = startDate.getTime();
  const endTimestamp = endDate.getTime();

  const days = Math.round(Math.abs((endTimestamp - startTimestamp) / oneDay)) || 1;

  const totalPrice = pricePerNight * days * numberOfGuests;
  return totalPrice;
}
