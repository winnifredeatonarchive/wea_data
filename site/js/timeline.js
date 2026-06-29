/* Timeline decade nav: highlight the current decade bubble while scrolling,
   and wire up the top/bottom jump arrows. */
(function () {
    "use strict";

    var nav = document.querySelector('#timeline .decadeNav');
    if (!nav) { return; }

    // The decade pills (skip the up/down arrows).
    var links = Array.prototype.slice.call(nav.querySelectorAll('a[href^="#d"]'));

    // Pair each pill with the section it points to.
    var sections = links.map(function (link) {
        return { link: link, el: document.getElementById(link.getAttribute('href').slice(1)) };
    }).filter(function (s) { return s.el; });

    function setActive(activeLink) {
        links.forEach(function (l) {
            l.classList.toggle('active', l === activeLink);
        });
        // Keep the highlighted pill in view inside the horizontal scroller.
        if (activeLink && activeLink.scrollIntoView) {
            activeLink.scrollIntoView({ block: 'nearest', inline: 'center' });
        }
    }

    // Anything above this Y line counts as "passed" (clears the sticky nav).
    function lineY() {
        return nav.getBoundingClientRect().bottom + 8;
    }

    function onScroll() {
        if (!sections.length) { return; }
        var current = sections[0];
        var y = lineY();
        for (var i = 0; i < sections.length; i++) {
            if (sections[i].el.getBoundingClientRect().top <= y) {
                current = sections[i];
            } else {
                break;
            }
        }
        setActive(current.link);
    }

    var ticking = false;
    window.addEventListener('scroll', function () {
        if (!ticking) {
            window.requestAnimationFrame(function () { onScroll(); ticking = false; });
            ticking = true;
        }
    }, { passive: true });
    window.addEventListener('resize', onScroll, { passive: true });

    // Up / down jump arrows.
    var upBtn = nav.querySelector('.decadeNav-top');
    var downBtn = nav.querySelector('.decadeNav-bottom');
    if (upBtn) {
        upBtn.addEventListener('click', function (e) {
            e.preventDefault();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }
    if (downBtn) {
        downBtn.addEventListener('click', function (e) {
            e.preventDefault();
            window.scrollTo({ top: document.documentElement.scrollHeight, behavior: 'smooth' });
        });
    }

    onScroll();
}());
