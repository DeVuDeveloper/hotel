import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import 'flatpickr/dist/themes/dark.css'

export default class extends Controller {
  connect() {
    flatpickr(".start_date", {
      enableTime: true,
      dateFormat: "F j, Y h:i K",
      disable: [
        function (date) {
          return date.getDay() === 0 || date.getDay() === 6;
        },
      ],
      locale: {
        firstDayOfWeek: 0,
      },
    });
    flatpickr(".end_date", {
      enableTime: true,
      dateFormat: "F j, Y h:i K",
      disable: [
        function (date) {
          return date.getDay() === 0 || date.getDay() === 6;
        },
      ],
      locale: {
        firstDayOfWeek: 0,
      },
    });
  }
}
