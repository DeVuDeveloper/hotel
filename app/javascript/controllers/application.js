import { Application } from "@hotwired/stimulus"
import "flatpickr"
const application = Application.start()

application.debug = false
window.Stimulus   = application

export { application }
