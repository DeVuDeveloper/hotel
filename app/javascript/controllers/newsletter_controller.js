import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize() {
    const isSubscribed = this.getSubscriptionCookie() === 'yes';
    if (!isSubscribed) {
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

  unsubscribe() {
    const user_id = this.data.get("user-id"); // Dohvatite user_id iz podataka na elementu
    const token = this.data.get("token"); // Dohvatite token iz podataka na elementu
  
    fetch(`/admin/dashboard/newsletters/unsubscribe/${user_id}/${token}`, {
      method: 'GET',
    })
    .then(response => {
      if (!response.ok) {
        throw Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      if (data.unsubscribed) {
        this.setSubscriptionCookie(false); // Postavite kolačić na "no" jer je korisnik odjavljen
        // Možete dodati dodatne radnje kao što je prikazivanje potvrde odjave
      } else {
        console.error('Unsubscription failed');
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
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
}
