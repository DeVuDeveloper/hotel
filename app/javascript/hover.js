const roomHovers = document.querySelectorAll('.room-hover');


roomHovers.forEach((cover) => {
  const roomId = cover.getAttribute('data-room-id');

  cover.addEventListener('mouseover', () => {
    const overlayIcons = cover.querySelector('.overlay-icons');
    overlayIcons.style.opacity = 1;
  });

  cover.addEventListener('mouseout', () => {
    const overlayIcons = cover.querySelector('.overlay-icons');
    overlayIcons.style.opacity = 0;
  });
});
