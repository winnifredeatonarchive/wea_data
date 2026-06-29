(function () {
    "use strict";
    Array.prototype.slice.call(document.querySelectorAll('.decadeNav')).forEach(initDecadeNav);

    function initDecadeNav(nav) {
        var links = Array.prototype.slice.call(nav.querySelectorAll('li:not(.decadeNav-jump) a'));
        var sections = links.map(function (link) {
            return { link: link, el: document.getElementById(link.getAttribute('href').slice(1)) };
        }).filter(function (s) { return s.el; });

        function setActive(activeLink) {
            links.forEach(function (l) { l.classList.toggle('active', l === activeLink); });
            if (!activeLink) { return; }
            // Scroll ONLY the nav strip horizontally — never the page/window.
            var navR = nav.getBoundingClientRect(), linkR = activeLink.getBoundingClientRect();
            if (linkR.left < navR.left) { nav.scrollLeft -= (navR.left - linkR.left) + 16; }
            else if (linkR.right > navR.right) { nav.scrollLeft += (linkR.right - navR.right) + 16; }
        }
        function lineY() { return nav.getBoundingClientRect().bottom + 8; }
        function onScroll() {
            if (!sections.length) { return; }
            var current = sections[0], y = lineY();
            for (var i = 0; i < sections.length; i++) {
                if (sections[i].el.getBoundingClientRect().top <= y) { current = sections[i]; }
                else { break; }
            }
            setActive(current.link);
        }
        var ticking = false;
        window.addEventListener('scroll', function () {
            if (!ticking) { requestAnimationFrame(function () { onScroll(); ticking = false; }); ticking = true; }
        }, { passive: true });
        window.addEventListener('resize', onScroll, { passive: true });

        var scroller = document.scrollingElement || document.documentElement;
        var up = nav.querySelector('.decadeNav-top'), down = nav.querySelector('.decadeNav-bottom');
        if (up) up.addEventListener('click', function (e) { e.preventDefault(); window.scrollTo({ top: 0, behavior: 'smooth' }); });
        if (down) down.addEventListener('click', function (e) { e.preventDefault(); window.scrollTo({ top: scroller.scrollHeight, behavior: 'smooth' }); });

        onScroll();
    }
}());