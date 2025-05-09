import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

console.log('tractor js');
console.log("bootstrap!");

document.addEventListener('turbo:load', loadEditors);

function loadEditors(event) {
  console.log('got loaded!');
  // document.querySelectorAll('.easymde').forEach(function(mdetextarea) {
  //   console.log(mdetextarea);
  //   var editor = new EasyMDE({
  //     element: mdetextarea      
  //   }); 
  // });
  // const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  // const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

}




