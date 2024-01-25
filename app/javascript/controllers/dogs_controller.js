import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "image", "breed", "breedName","errorMessage"]; // Added errorMessage target

  submitForm(event) {
    event.preventDefault();
    const action = this.formTarget.action;
    const breed = this.breedTarget.value;
    const url =  `${action}?breed=${encodeURIComponent(breed)}`;
    this.errorMessageTarget.classList.add('hidden'); // Hide error message initially

    fetch(url, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json'
      },
    })
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        this.errorMessageTarget.textContent = data.error;
        this.errorMessageTarget.classList.remove('hidden');
      } else {
        this.imageTarget.innerHTML = `<img src="${data.image_url}" alt="${breed}" class="max-w-full h-auto rounded-lg shadow-md">`;
        this.breedNameTarget.textContent = breed.charAt(0).toUpperCase() + breed.slice(1);
        this.errorMessageTarget.classList.add('hidden');
      }    
    })
    .catch(error => {
      console.error('Error:', error);
      this.errorMessageTarget.textContent = "An error occurred while fetching the image.";
      this.errorMessageTarget.classList.remove('hidden');
    });
  }
}
