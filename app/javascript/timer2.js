function newslettersBanner() {
  var newsletterBanner = document.querySelector('#newsletterMessage .modal-content');
  if (newsletterBanner) {
      newsletterBanner.style.display = 'none';
      setTimeout(function () {
          newsletterBanner.style.display = 'block';
      }, 4000);
  }
}

window.addEventListener('load', newslettersBanner);
