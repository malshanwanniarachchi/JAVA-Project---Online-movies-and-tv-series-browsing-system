// Get all tab links and sections
const tabLinks = document.querySelectorAll('.tab-menu a');
const sections = document.querySelectorAll('.content-area section');

document.addEventListener('DOMContentLoaded', function() {
        const aboutUsTab = document.querySelector('.tab-menu li:first-of-type a');
        aboutUsTab.classList.add('active');
      });
// Add event listener to each tab link
tabLinks.forEach((link) => {
  link.addEventListener('click', (e) => {
    e.preventDefault();

    // Remove active class from all tab links and sections
    tabLinks.forEach((tabLink) => tabLink.classList.remove('active'));
    sections.forEach((section) => section.style.display = 'none');

    // Add active class to clicked tab link and display corresponding section
    link.classList.add('active');
    const targetSectionId = link.getAttribute('href').substring(1);
    const targetSection = document.getElementById(targetSectionId);
    targetSection.style.display = 'block';
  });
});

// Get all sub-tab links and sections
const subTabLinks = document.querySelectorAll('.sub-tab-menu a');
const subSections = document.querySelectorAll('.sub-content-area section');

// Add event listener to each sub-tab link
subTabLinks.forEach((link) => {
  link.addEventListener('click', (e) => {
    e.preventDefault();

    // Remove active class from all sub-tab links and sections
    subTabLinks.forEach((subTabLink) => subTabLink.classList.remove('active'));
    subSections.forEach((subSection) => subSection.style.display = 'none');

    // Add active class to clicked sub-tab link and display corresponding section
    link.classList.add('active');
    const targetSubSectionId = link.getAttribute('href').substring(1);
    const targetSubSection = document.getElementById(targetSubSectionId);
    targetSubSection.style.display = 'block';
  });
});
