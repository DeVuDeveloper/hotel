document.addEventListener('turbo:load', function () {
    const showFavoriteRoomsButton = document.getElementById('show-favorite-rooms-button');
    const favoriteRoomsPopup = document.getElementById('favorite-rooms-popup');
  
    showFavoriteRoomsButton.addEventListener('click', function () {
      // Proverite da li je popup već otvoren
      if (favoriteRoomsPopup.classList.contains('hidden')) {
        // Ovde možete generisati dinamički sadržaj za popup na osnovu omiljenih soba
        const favoriteRoomsContent = generateFavoriteRoomsContent(); // Funkcija koja generiše sadržaj
  
        // Postavite sadržaj popupa
        favoriteRoomsPopup.innerHTML = favoriteRoomsContent;
  
        // Prikažite popup
        favoriteRoomsPopup.classList.remove('hidden');
      } else {
        // Ako je popup već otvoren, zatvorite ga
        favoriteRoomsPopup.classList.add('hidden');
      }
    });
  
    // Funkcija za generisanje sadržaja pop-up prozora
    function generateFavoriteRoomsContent() {
      // Ovde možete generisati sadržaj pop-up prozora na osnovu omiljenih soba
      // Na primer, možete koristiti JavaScript da dohvatite omiljene sobe iz kolačića
      const favoriteRooms = Cookies.getJSON('favorite_rooms') || [];
  
      let content = '';
      favoriteRooms.forEach(function (room) {
        content += `<li>${room.name}</li>`;
      });
  
      return content;
    }
  });
  
  
  
  
  
  
  
  
   