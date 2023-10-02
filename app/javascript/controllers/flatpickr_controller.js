import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import 'flatpickr/dist/themes/dark.css'

export default class extends Controller {
  connect() {
    flatpickr(".start_date", {
      enableTime: true,
      dateFormat: "F j, Y h:i K",
      minDate: "today",
      locale: {
        firstDayOfWeek: 0,
      },
    });
    flatpickr(".end_date", {
      enableTime: true,
      dateFormat: "F j, Y h:i K",
      minDate: "today",
      locale: {
        firstDayOfWeek: 0,
      },
    });
  }
}
