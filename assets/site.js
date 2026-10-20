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

})();
