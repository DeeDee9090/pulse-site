// PULSE landing site — tiny bits of interactivity (no dependencies)
(function () {
  // Mobile nav toggle
  var burger = document.getElementById('navBurger');
  var links = document.querySelector('.nav-links');
  if (burger && links) {
    burger.addEventListener('click', function () { links.classList.toggle('open'); });
    links.addEventListener('click', function (e) {
      if (e.target.tagName === 'A') links.classList.remove('open');
    });
  }

  // Reveal-on-scroll for sections/cards
  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (en) {
      if (en.isIntersecting) { en.target.style.opacity = 1; en.target.style.transform = 'none'; io.unobserve(en.target); }
    });
  }, { threshold: 0.12 });
  document.querySelectorAll('.feature, .mini, .how-step, .step, .quote').forEach(function (el) {
    el.style.opacity = 0; el.style.transform = 'translateY(24px)';
    el.style.transition = 'opacity .6s ease, transform .6s ease';
    io.observe(el);
  });
})();
