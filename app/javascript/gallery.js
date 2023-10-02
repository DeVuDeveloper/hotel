document.addEventListener("turbo:load", function() {
  let largeImage = document.getElementById("largeImage");
  let thumbnailContainer = document.querySelector("[data-gallery-target='thumbnails']");

  if (thumbnailContainer) {
    let thumbnails = thumbnailContainer.querySelectorAll(".thumbnail-image");
    let currentIndex = 0;
    let slideshowInterval;

    function showImage(index) {
      if (thumbnails[index]) {
        largeImage.src = thumbnails[index].querySelector("img").src;
      }
    }

    function startSlideshow() {
      function updateSlide() {
        currentIndex = (currentIndex + 1) % thumbnails.length;
        showImage(currentIndex);
      }

      slideshowInterval = setInterval(updateSlide, 3000);
    }

    function resetSlideshow() {
      clearInterval(slideshowInterval);
      startSlideshow();
    }

    thumbnails.forEach((thumbnail, index) => {
      thumbnail.addEventListener("click", function() {
        showImage(index);
        resetSlideshow();
      });

      thumbnail.addEventListener("mouseover", function() {
        showImage(index);
        resetSlideshow();
      });
    });

    startSlideshow();
  }
});
