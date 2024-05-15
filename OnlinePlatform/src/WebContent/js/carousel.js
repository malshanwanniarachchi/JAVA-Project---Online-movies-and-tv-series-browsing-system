
// Get all the tab buttons and carousel elements
const tabButtons = document.querySelectorAll('.tab-button');
const carousels = document.querySelectorAll('.carousel');

// Add click event listeners to tab buttons
  tabButtons.forEach((button) => {
  button.addEventListener('click', (e) => {
	e.preventDefault();

	// Remove 'active' class from all tab buttons
	tabButtons.forEach((btn) => {
	  btn.classList.remove('active');
	});

	// Add 'active' class to the clicked tab button
	button.classList.add('active');

	 // Hide all carousels
       carousels.forEach((carousel) => {
      if (carousel.getAttribute('id') !== 'top-rated-carousel') {
        carousel.style.display = 'none';
      }
    });

	// Get the ID of the target carousel from the href attribute
	const targetCarouselId = button.getAttribute('href');

	// Display the target carousel
	const targetCarousel = document.querySelector(targetCarouselId);
	if (targetCarousel) {
	  targetCarousel.style.display = 'flex';
	}
  });
});

// Initially hide all carousels except the "Top Free" carousel
carousels.forEach((carousel) => {
  if ((carousel.getAttribute('id') !== 'top-free') && (carousel.getAttribute('id') !== 'top-rated-carousel')) {
	carousel.style.display = 'none';
  }
});

// Add 'active' class to the "Top Free" tab button
const topFreeTabButton = document.querySelector('.tab-button[href="#top-free"]');
if (topFreeTabButton) {
  topFreeTabButton.classList.add('active');
}


// Get the carousel element
const carousel = document.querySelector('.carousel');


  function setupCarousel(carousel) {
  const carouselContainer = carousel.parentElement;
  const leftArrow = carouselContainer.querySelector('.left-arrow');
  const rightArrow = carouselContainer.querySelector('.right-arrow');

  let scrollPosition = 0;
  const scrollAmount = 25; // Adjust the value based on your layout

  leftArrow.addEventListener('click', () => {
	if (scrollPosition > 0) {
	  scrollPosition -= scrollAmount;
	  carousel.style.transform = `translateX(-${scrollPosition}%)`;
	}
	
  });

  rightArrow.addEventListener('click', () => {
	const maxScroll = carousel.scrollWidth - carouselContainer.clientWidth;
	if (scrollPosition < maxScroll) {
	  scrollPosition += scrollAmount;
	  carousel.style.transform = `translateX(-${scrollPosition}%)`;
	}
	

  });
}

carousels.forEach((carousel) => {
setupCarousel(carousel);
});

