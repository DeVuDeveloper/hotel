function showCookiesBanner() {
    var cookiesBanner = document.getElementById('cookies-bar');
    if (cookiesBanner) {
      cookiesBanner.style.display = 'none';
      setTimeout(function () {
        cookiesBanner.style.display = 'block';
      }, 4000);
    }
  }

  window.addEventListener('load', showCookiesBanner);