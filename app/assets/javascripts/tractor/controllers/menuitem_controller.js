import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('menuitem connect')
  }

  static get targets() {
    return ["name", "results", "q", "menuitemableId", "menuitemableType", "record"]
  }

  search(e) {
    console.log('search')
    this.menuitemableIdTarget.value = ''
    this.menuitemableTypeTarget.value = ''
    this.recordTarget.innerHTML = ''
    this.resultsTarget.innerHTML = 'searching'
    e.preventDefault()

    fetch(`/admin/links/menuitems?q=${this.qTarget.value}`)
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = data["content"]
      })
      .catch(error => {
        console.log('Error:', error)
        this.resultsTarget.innerHTML = 'An error occurred'
      })
  }

  selectOption(e) {
    console.log(e.target.dataset.record)
    e.preventDefault()
    this.qTarget.value = e.target.dataset.link
    this.nameTarget.value = e.target.dataset.title
    this.menuitemableIdTarget.value = e.target.dataset.id
    this.menuitemableTypeTarget.value = e.target.dataset.type
    this.recordTarget.innerHTML = '' + e.target.dataset.record

    this.resultsTarget.innerHTML = ''
  }
}