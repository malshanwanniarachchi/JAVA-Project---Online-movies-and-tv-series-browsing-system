// Get all the tab menu items
const tabMenuItems = document.querySelectorAll('.tab-menu a');

// Get all the tab content sections
const tabContents = document.querySelectorAll('.tab-content');

// Add click event listeners to each tab menu item
tabMenuItems.forEach((menuItem, index) => {
  menuItem.addEventListener('click', (event) => {
    event.preventDefault();

    // Remove 'active' class from all tab menu items
    tabMenuItems.forEach((item) => {
      item.classList.remove('active');
    });

    // Add 'active' class to the clicked tab menu item
    menuItem.classList.add('active');

    // Get the target content ID from the href attribute
    const target = menuItem.getAttribute('href');

    // Hide all tab content sections
    tabContents.forEach((content) => {
      content.style.display = 'none';
    });

    // Show the target tab content section
    document.querySelector(target).style.display = 'block';
  });

  // Set the first tab menu item and tab content section as active by default
  if (index === 0) {
    menuItem.classList.add('active');
    const target = menuItem.getAttribute('href');

    // Check if the target content is the dashboard content
    if (target === '#dashboard') {
      document.querySelector(target).style.display = 'block';
    } else {
      document.querySelector(target).style.display = 'none';
    }
  } else {
    const target = menuItem.getAttribute('href');
    document.querySelector(target).style.display = 'none';
  }
});
