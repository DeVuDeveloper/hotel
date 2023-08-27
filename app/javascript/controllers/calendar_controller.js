import { Controller } from "@hotwired/stimulus";
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";

export default class extends Controller {
  connect() {
    console.log('connect  stimulus')
    console.log('roomId:', this.data.get("room-id"));
    console.log('calendarId:', this.data.get("calendar-id"));
    this.loadCalendar();
  }

  loadCalendar() {
    const calendarEl = this.element;
    const roomId = this.data.get("roomId");
    const calendarId = this.data.get("calendarId");
    const eventsUrl = `/rooms/${roomId}/calendars/${calendarId}/calendar_entries`;

    const calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin],
      events: eventsUrl,
      validRange: {
        start: new Date().toISOString().split('T')[0],
      },
      eventContent: this.eventContentCallback.bind(this)
    });

    calendar.render();
  }

  eventContentCallback(arg) {
    const { price, bg_color, season } = arg.event.extendedProps;
    
    const eventContent = document.createElement("div");
    eventContent.classList.add('custom-event');
    eventContent.innerHTML = `
      <div class="event-price">${price}</div>
      <div class="event-season">${season}</div>
    `;
    eventContent.style.backgroundColor = bg_color;
    eventContent.style.padding = '1.5rem';
  
    return { domNodes: [eventContent] };
  }
}
