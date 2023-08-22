import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "startDate",
    "endDate",
    "guests",
    "totalPrice",
    "pricePerNight",
  ];
  static values = { pricePerNight: Number };

  connect() {
    console.log("Controller connected");
    this.updateTotalPrice();

    const guestsInput = this.guestsTarget;
    guestsInput.addEventListener("input", this.updateTotalPrice.bind(this));
    const startDateInput = this.startDateTarget;
    const endDateInput = this.endDateTarget;

    startDateInput.addEventListener("change", this.updateTotalPrice.bind(this));
    endDateInput.addEventListener("change", this.updateTotalPrice.bind(this));
  }

  updateTotalPrice() {
    const startDateString = this.startDateTarget.value;
    const endDateString = this.endDateTarget.value;
    const startDate = new Date(startDateString + "T00:00:00Z");
    const endDate = new Date(endDateString + "T00:00:00Z");
    const numberOfGuests = parseInt(this.guestsTarget.value);

    const totalPrice = this.calculateTotalPrice(
      startDate,
      endDate,
      numberOfGuests
    );

    const formattedTotalPrice = isNaN(totalPrice) ? 0.0 : totalPrice.toFixed(2);

    this.totalPriceTarget.textContent = `$ ${formattedTotalPrice}`;
  }

  calculateTotalPrice(startDate, endDate, numberOfGuests) {
    const oneDay = 24 * 60 * 60 * 1000;
    const days = Math.round(Math.abs((endDate - startDate) / oneDay)) || 1;
    const totalPrice = this.pricePerNightValue * days * numberOfGuests;
    return totalPrice;
  }
}
