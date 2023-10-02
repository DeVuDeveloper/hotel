import { Controller } from "@hotwired/stimulus";
import moment from "moment";

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
    const numberOfGuests = parseInt(this.guestsTarget.value);
    const startDate = moment(startDateString, "MMMM D, YYYY h:mm A");
    const endDate = moment(endDateString, "MMMM D, YYYY h:mm A");
    const days = endDate.diff(startDate, "days") || 1;
    const totalPrice = this.calculateTotalPrice(startDate, endDate, numberOfGuests);
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
