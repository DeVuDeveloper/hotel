import { Controller } from "@hotwired/stimulus";
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";

export default class extends Controller {
  connect() {
    console.log("Connected calendar");

    this.calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin],
      events: this.loadEvents.bind(this),
      eventClick: this.showEventDetails.bind(this),
      eventBackgroundColor: "green",
    });

    this.calendar.render();
  }

  loadEvents(info, successCallback) {
    const roomId = this.data.get("roomId");
    console.log("Loading events for room ID:", roomId);

    fetch(`/rooms/${roomId}/availability`)
      .then(response => response.json())
      .then(data => {
        console.log("Received data from server:", data);

        const events = data.map(entry => ({
          title: entry.title,
          start: entry.start,
          price: entry.price,
          backgroundColor: entry.backgroundColor,
        }));
        successCallback(events);
      });
  }

  showEventDetails(info) {
    console.log("Showing event details for:", info.event);

    const event = info.event;
    console.log("Event details:", event);

    const content = `
      <p>${event.title}</p>
      <p>Date: ${event.start}</p>
      <p>Price: $${event.price}</p>
    `;
  }
}


