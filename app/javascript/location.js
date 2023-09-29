document.addEventListener('DOMContentLoaded', function () {
  window.requestLocationPermission = function () {
    console.log('requestLocationPermission() je pozvan.'); 
    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition(function(position) {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        
        sendDataToServer(latitude, longitude);
      }, function(error) {
        if (error.code === 1) {
        }
      });
    }
  }

  function sendDataToServer(latitude, longitude) {

    const bookNowLink = document.getElementById('book-now-link');
    const userId = bookNowLink.getAttribute('data-user-id');
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      console.log('Trenutni korisnik ID:', userId);
 
    const data = {
      user_id: userId,
      latitude: latitude,
      longitude: longitude,
    };
  
    fetch('/api/send-location', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
      body: JSON.stringify(data),
    })
      .then(response => response.json())
      .then(data => {

        console.log(data.message);
      })
      .catch(error => {
        console.error('Greška prilikom slanja podataka na server:', error);
      });
  }
});
