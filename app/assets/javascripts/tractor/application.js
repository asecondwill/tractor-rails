import "@hotwired/turbo-rails"
import "controllers"

console.log('tractor js');

// document.addEventListener('turbo:load', loadEditors)

// function loadEditors(event) {
//   document.querySelectorAll('.easymde').forEach(function(mdetextarea) {
//     console.log(mdetextarea);
//     var editor = new EasyMDE({
//       element: mdetextarea      
//     }); 
//   });
//   const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
//   const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

// }