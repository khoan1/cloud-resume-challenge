// JavaScript for Hamburger Menu and Highlight active section

// Hamburger toggle
const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('nav-links');

hamburger.addEventListener('click', () => {
    navLinks.classList.toggle('active');
    hamburger.classList.toggle('open');
});

// Close menu when clicking a link
document.querySelectorAll('#nav-links a').forEach(link => {
    link.addEventListener('click', () => {
        navLinks.classList.remove('active');
        hamburger.classList.remove('open');
    });
});

// Highlight active section
const sections = document.querySelectorAll("section");
const navItems = document.querySelectorAll("nav ul li a");

window.addEventListener("scroll", () => {
    let current = "";
    sections.forEach(section => {
        const sectionTop = section.offsetTop - 120;
        if (scrollY >= sectionTop) current = section.getAttribute("id");
    });

    navItems.forEach(a => {
        a.classList.remove("active");
        if (a.getAttribute("href") === "#" + current) {
            a.classList.add("active");
        }
    });
});



// JavaScript for Back to Top button and Page View Counter

// Back to top
document.getElementById("back-to-top").addEventListener("click", () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
});

// Page view counter
fetch("https://your-api-gateway-endpoint.com/views")
    .then(response => response.json())
    .then(data => {
        document.getElementById("view-count").textContent = data.views;
    })
    .catch(() => {
        document.getElementById("view-count").textContent = "N/A";
    });