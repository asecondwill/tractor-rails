import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap";


export default class extends Controller {
  connect() {
    console.log('modal controller!')
  }


  open(event) {
    console.log(" opening modal...");
    const modalElement = document.getElementById("tractor-modal");
    const modal = new bootstrap.Modal(modalElement); 
    modal.show();
  }
  
}