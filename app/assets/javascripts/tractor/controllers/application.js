import { Application } from "@hotwired/stimulus"
import { MarksmithController, ListContinuationController } from "@avo-hq/marksmith"

const application = Application.start()

// Configure Stimulus
application.warnings = true
application.debug = false
window.Stimulus = application

export { application }

application.register("marksmith", MarksmithController)
application.register("list-continuation", ListContinuationController)