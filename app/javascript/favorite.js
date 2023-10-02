document.addEventListener('turbo:load', function () {
  function updateFavoriteCountInNavbar() {
    const favoriteCountElement = document.getElementById('favorite-count');
    const favorites = Cookies.getJSON('favorite_rooms') || [];

    if (favoriteCountElement) {
      favoriteCountElement.textContent = favorites.length;
    }
  }

  document.body.addEventListener('click', function (event) {
    if (event.target.classList.contains('favorite-icon')) {
      const icon = event.target;
      const roomId = icon.getAttribute('data-room-id');
      const roomName = icon.getAttribute('data-room-name');

      let favorites = Cookies.getJSON('favorite_rooms') || [];

      if (!favorites.some(room => room.id === roomId)) {
        favorites.push({ id: roomId, name: roomName });
        icon.classList.add('active');
        Cookies.set('favorite_rooms', favorites, { expires: 365 });
      } else {
        const index = favorites.findIndex(room => room.id === roomId);
        if (index > -1) {
          favorites.splice(index, 1);
          icon.classList.remove('active');
        }
        Cookies.set('favorite_rooms', favorites, { expires: 365 });
      }

      updateFavoriteCountInNavbar();
    }
  });

  updateFavoriteCountInNavbar();
});
