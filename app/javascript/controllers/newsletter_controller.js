import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize() {
    const isSubscribed = this.getSubscriptionCookie() === 'yes';
    const hasDeclined = this.getDeclinedCookie() === 'yes';

    if (!isSubscribed && !hasDeclined) {
      this.openModal();
    }
  }

  subscribe() {
    const isSubscribed = this.getSubscriptionCookie() === 'yes';

    if (!isSubscribed) {
      fetch('/admin/dashboard/newsletters/subscribe', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ subscribed: true })
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          if (data.subscribed) {
            this.setSubscriptionCookie(true);
            this.closeModal();
          } else {
            console.error('Subscription update failed');
          }
        })
        .catch(error => {
          console.error('Error:', error);
        });
    } else {
      this.closeModal();
    }
  }

  decline() {
    this.setSubscriptionCookie(false);
    this.setDeclinedCookie(true);
    this.closeModal();
  }

  openModal() {
    const modalElement = this.modalTarget;
    modalElement.style.display = "block";
  }

  closeModal() {
    const modalElement = this.modalTarget;
    modalElement.style.display = "none";
  }

  get modalTarget() {
    return this.targets.find("modal");
  }

  getSubscriptionCookie() {
    return Cookies.get('subscribed');
  }

  setSubscriptionCookie(subscribed) {
    Cookies.set('subscribed', subscribed ? 'yes' : 'no', {
      expires: 365
    });
  }

  getDeclinedCookie() {
    return Cookies.get('declined');
  }

  setDeclinedCookie(declined) {
    Cookies.set('declined', declined ? 'yes' : 'no', {
      expires: 365
    });
  }
}
