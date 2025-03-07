import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    console.log('dragger')
    var nestedSortables = [].slice.call(document.querySelectorAll('.nested'));
    // Loop through each nested sortable element
    for (var i = 0; i < nestedSortables.length; i++) {
      new Sortable(nestedSortables[i], {
        group: 'nested',
        animation: 150,
        fallbackOnBody: true,
        swapThreshold: 0.65,
        onEnd: this.end.bind(this),
      });
    }
  }

  async end(event) {
    let id = event.item.dataset.id
    let parent_node = event.item.closest('.nested')
    let data = new FormData()
    data.append("position", event.newIndex + 1)
    data.append("ancestry", parent_node.dataset.id)

    try {
      const response = await fetch(this.data.get("url").replace(":id", id), {
        method: 'PATCH',
        body: data,
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
      })

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }
    } catch (error) {
      console.error('Error:', error)
    }
  }
}