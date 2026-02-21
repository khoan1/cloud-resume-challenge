// Version 1.3

// JavaScript for Hamburger Menu and Highlight active section

// Hamburger menu toggle
const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('nav-links');

hamburger.addEventListener('click', () => {
    navLinks.classList.toggle('active'); // show/hide menu
    hamburger.classList.toggle('open');  // animate hamburger to X
});

// Nav Items and Sections
const sections = document.querySelectorAll("section"); // all page sections
const navItems = document.querySelectorAll("nav ul li a"); // nav links

// Smooth scroll links (nav + buttons)
const smoothScrollLinks = document.querySelectorAll('a[href^="#"]'); // all anchor links to sections

let isAutoScrolling = false; // flag to prevent scroll handler during smooth scroll

// Smooth Scroll Functionality
smoothScrollLinks.forEach(link => {
    link.addEventListener('click', (e) => {
        e.preventDefault(); // prevent default jump

        const targetId = link.getAttribute('href').substring(1);
        const target = document.getElementById(targetId);

        if (!target) return; // safety check

        isAutoScrolling = true; // disable scroll highlight while scrolling

        // Remove previous active nav item
        navItems.forEach(a => a.classList.remove('active'));

        // Highlight the corresponding nav item instantly (if exists)
        const navLink = document.querySelector(`nav ul li a[href="#${targetId}"]`);
        if (navLink) navLink.classList.add('active');

        // Close hamburger menu if open
        navLinks.classList.remove('active');
        hamburger.classList.remove('open');

        // Smooth scroll to target
        target.scrollIntoView({ behavior: "smooth" });

        // Reset auto-scroll flag after smooth scroll duration
        setTimeout(() => { isAutoScrolling = false; }, 500); // match CSS smooth scroll timing
    });
});

// Scroll Highlight Function
function updateActiveNav() {
    if (isAutoScrolling) return; // skip during programmatic scroll

    let current = "";

    sections.forEach(section => {
        const sectionBounds = section.getBoundingClientRect();

        // Check if the "indicator line" is inside the section
        if (sectionBounds.top <= 150 && sectionBounds.bottom >= 150) {
            current = section.id;
        }
    });

    // Update nav link highlight
    navItems.forEach(a => {
        a.classList.toggle(
            "active",
            a.getAttribute("href") === "#" + current
        );
    });
}

// Run once on page load to fix initial highlight bug
updateActiveNav();

// Run on scroll
window.addEventListener("scroll", updateActiveNav);

// Back to Top Button Functionality
const backToTop = document.getElementById("back-to-top");

backToTop.addEventListener('click', () => {
    isAutoScrolling = true; // prevent highlight jump
    navItems.forEach(a => a.classList.remove('active')); // remove current highlight

    window.scrollTo({ top: 0, behavior: "smooth" });

    // Highlight first section/nav
    const firstNav = document.querySelector(`nav ul li a[href="#${sections[0].id}"]`);
    if (firstNav) firstNav.classList.add('active');

    setTimeout(() => { isAutoScrolling = false; }, 500); // match smooth scroll timing
});


// JavaScript for Page View Counter

// Page view counter element
const counterElement = document.getElementById("view-count");

// Page view counter
fetch("https://25fu0kaf82.execute-api.us-east-1.amazonaws.com/count")
    .then(response => response.json())
    .then(data => {
        counterElement.textContent = data.count; // Display the visitor count
    })
    // Handle errors
    .catch(error => {
        console.error("Error fetching visitor count:", error);
        counterElement.textContent = "N/A";
    });