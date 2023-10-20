import { application } from "./application"

import CalendarController from "./calendar_controller"
application.register("calendar", CalendarController)

import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController )

import ChatbotController from "./chatbot_controller"
application.register("chatbot", ChatbotController)

import NewsletterController from "./newsletter_controller"
application.register("newsletter", NewsletterController)

import PushController from "./push_controller"
application.register("push", PushController)

import ReservationController from "./reservation_controller"
application.register("reservation", ReservationController)