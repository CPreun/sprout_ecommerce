import { Controller } from '@hotwired/stimulus';
import { Turbo } from '@hotwired/turbo-rails';

export default class extends Controller {
  // static targets = ['category'];

  change(event) {
    console.log('Category changed');
    console.log(event.target.value);
  }

  connect() {
    console.log('Category controller connected');
  }

  updateSubcategories() {
    console.log('hello')
    const categoryId = this.categoryTarget.value;
    this.fetchAndUpdate(`/update_subcategories?category_id=${categoryId}`);
  }

  fetchAndUpdate(url) {
    fetch(url, {
        method: 'GET',
        headers: {
            Accept: 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': this.getMetaContent('csrf-token'),
            'Cache-Control': 'no-cache',
        }
    })
    .then(response => response.ok ? response.text() : Promise.reject(response))
    .then(html => Turbo.renderStreamMessage(html))
    .catch(error => console.error('Error:', error));
  }

  getMetaContent(name) {
    return document.querySelector(`meta[name="${name}"]`).getAttribute('content');
  }
}