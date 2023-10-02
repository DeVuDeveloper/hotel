import { Application } from "@hotwired/stimulus"

const application = Application.start()
import "flatpickr"

application.debug = false
window.Stimulus   = application

export { application }
