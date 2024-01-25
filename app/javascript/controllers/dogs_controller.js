import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "image", "breed"];

  submitForm(event) {
    event.preventDefault();
    const url = this.formTarget.action;
    const breed = this.breedTarget.value;
    fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ breed })
    })
    .then(response => response.json())
    .then(data => {
      this.imageTarget.innerHTML = `<img src="${data.image_url}" alt="${breed}">`;
    });
  }
}
