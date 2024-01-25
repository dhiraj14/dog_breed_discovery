import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "image", "breed", "errorMessage"]; // Added errorMessage target

  submitForm(event) {
    event.preventDefault();
    const url = this.formTarget.action;
    const breed = this.breedTarget.value;
    this.errorMessageTarget.classList.add('hidden'); // Hide error message initially

    fetch(url, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ breed })
    })
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        this.errorMessageTarget.textContent = data.error;
        this.errorMessageTarget.classList.remove('hidden');
      } else {
        this.imageTarget.innerHTML = `<img src="${data.image_url}" alt="${breed}">`;
      }
    })
    .catch(error => {
      console.error('Error:', error);
      this.errorMessageTarget.textContent = "An error occurred while fetching the image.";
      this.errorMessageTarget.classList.remove('hidden');
    });
  }
}
