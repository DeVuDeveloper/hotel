document.addEventListener('turbo:load', function () {
    const showFavoriteRoomsButton = document.getElementById('show-favorite-rooms-button');
    const favoriteRoomsPopup = document.getElementById('favorite-rooms-popup');
  
    showFavoriteRoomsButton.addEventListener('click', function () {
      if (favoriteRoomsPopup.classList.contains('hidden')) {

        const favoriteRoomsContent = generateFavoriteRoomsContent();
  
        favoriteRoomsPopup.innerHTML = favoriteRoomsContent;
  
        favoriteRoomsPopup.classList.remove('hidden');
      } else {

        favoriteRoomsPopup.classList.add('hidden');
      }
    });
 
    function generateFavoriteRoomsContent() {
      
      const favoriteRooms = Cookies.getJSON('favorite_rooms') || [];
  
      let content = '';
      favoriteRooms.forEach(function (room) {
        content += `<li>${room.name}</li>`;
      });
  
      return content;
    }
  });
  
  
  
  
  
  
  
  
   