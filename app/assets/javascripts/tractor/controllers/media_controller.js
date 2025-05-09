import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";


export default class extends Controller {
  connect() {
    console.log('media controller!')
  }

  selectItem(event){
    console.log('item selected')
    console.log(" closing modal...");
    console.log(event);
    event.preventDefault(); // Prevent the default link behavior
    event.stopPropagation(); // Stop the event from bubbling up to Turbo
    console.log('go on to actually close the modal');
    const modalElement = document.getElementById("tractor-modal");
    let modal = bootstrap.Modal.getInstance(modalElement); 
    if (!modal) {
      console.log('make modal')
      modal = new bootstrap.Modal(modalElement); // Initialize the modal if no instance exists
    }
    modal.hide();
  }
  
  
}