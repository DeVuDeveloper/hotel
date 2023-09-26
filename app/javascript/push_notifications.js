window.vapidPublicKey = 'BPbz8vC1xrZ-BqugctqVPwgl6B93NKaiEg-79X03nCaz42Vc7n5NS8XYcReam87IHR9ccxscTVAVd0sBQwDw8wg';

document.addEventListener('DOMContentLoaded', function() {
  if ('Notification' in window) {
    Notification.requestPermission().then(function(permission) {
      if (permission === 'granted') {
        console.log('User allowed notifications.');

        navigator.serviceWorker.register('/service-worker.js')
          .then(function(serviceWorkerRegistration) {
            console.log('Service Worker sucessfully registered', serviceWorkerRegistration);
            serviceWorkerRegistration.pushManager
              .getSubscription()
              .then(function(existingSubscription) {
                if (existingSubscription) {
                  console.log('There is almost active subscription.');
                 
                } else {
  
                  serviceWorkerRegistration.pushManager
                    .subscribe({
                      userVisibleOnly: true,
                      applicationServerKey: window.vapidPublicKey
                    })
                    .then(function(subscription) {
                      console.log('Subscription sucessfully saved', subscription);

                      var endpoint = subscription.endpoint;
                      var p256dh = btoa(String.fromCharCode.apply(null, new Uint8Array(subscription.getKey('p256dh'))));
                      var auth = btoa(String.fromCharCode.apply(null, new Uint8Array(subscription.getKey('auth'))));

                      saveSubscription(endpoint, p256dh, auth);
                    });
                }
              });
          })
          .catch(function(error) {
            console.error('Error during registration service Worker:', error);
          });
      } else if (permission === 'denied') {
        console.warn('User rejected to allow notifications.');
      } else {
        console.warn('User still didnt give answer about notifications.');
      }
    });
  } else {
    console.warn('Push notifications not supported.');
  }
});



function saveSubscription(endpoint, p256dh, auth) {
  fetch(' /admin/dashboard/push_notifications/subscribe', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    body: JSON.stringify({ endpoint, p256dh, auth })
  })
  .then(function(response) {
    if (response.ok) {
      console.log('Pretplata uspešno sačuvana na serveru.');
    } else {
      console.error('Greška prilikom čuvanja pretplate na serveru.');
    }
  })
  .catch(function(error) {
    console.error('Greška prilikom slanja pretplate na server:', error);
  });
}
