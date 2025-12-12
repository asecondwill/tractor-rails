import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";


export default class extends Controller {
  static values = {  
    controllerSelector: String,
    controllerName: String,
  
  }

  connect() {
    console.log('media controller!')
  }

  selectItem(event){
    console.log('item selected')
    const item = event.currentTarget; // The clicked element
    const attachments = [this.extractMetadataFromItem(item)]
    console.log(attachments)
    this.insertAttachments(attachments, event)

    this.hideModal(event)
  }

  insertAttachments(attachments, event) {
    // show an error if the controller is not found
    if (!this.otherController) {
      console.error(`[HoustonCms->] The Media Library failed to find any field outlets to inject the asset. Tried selector: ${this.controllerSelectorValue} and name: ${this.controllerNameValue}`)

      return
    }
    // Trigger the insertAttachment action on the other controller
    this.otherController.insertAttachments(attachments, event)
  }

  extractMetadataFromItem(item){
    // console.log(item);
    // Log each data attribute
    // console.log("Raw Blob Data:", item.dataset.mediaLibraryBlob);
    //const filename = item.dataset.mediaLibraryFilename;
    const blob = JSON.parse(item.dataset.mediaLibraryBlob);
    const path = item.dataset.mediaLibraryPath;    
    const url = item.dataset.mediaLibraryUrl;

    // console.log("Blob:", blob);
    // console.log("Path:", path);
    // console.log("Filename:", filename);
    // console.log("URL:", url);

    return { blob, path, url }
  }


  get otherController() {
    console.log(this.controllerSelectorValue)
    console.log(this.controllerNameValue)
    return this.application.getControllerForElementAndIdentifier(document.querySelector(this.controllerSelectorValue), this.controllerNameValue)
  }

  
  
  hideModal(event){    
    event.preventDefault(); // Prevent the default link behavior
    event.stopPropagation(); // Stop the event from bubbling up to Turbo   
    const modalElement = document.getElementById("houston-cms-modal");
    let modal = bootstrap.Modal.getInstance(modalElement); 
    if (!modal) {      
      modal = new bootstrap.Modal(modalElement); // Initialize the modal if no instance exists
    }
    modal.hide();
  }
}