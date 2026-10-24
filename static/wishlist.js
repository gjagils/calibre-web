(function() {
    var W = 'https://wishlist.gerdjan.nl';
    var K = '__WISHLIST_AUTOLOGIN_KEY__';  // wordt bij containerstart ingevuld uit WISHLIST_AUTOLOGIN_KEY
    function go() {
        var el = document.querySelector('a[href*="/me"]') || document.querySelector('.navbar-right .dropdown-toggle');
        if (!el) {
            var links = document.querySelectorAll('.navbar-right a, nav a');
            for (var i = 0; i < links.length; i++) {
                if (links[i].textContent.indexOf('gjagils') > -1 || links[i].textContent.indexOf('Afmelden') > -1) {
                    el = links[i];
                    break;
                }
            }
        }
        if (!el) return;

        var u = 'gjagils';
        var userLink = document.querySelector('a[href*="/me"]');
        if (userLink) u = userLink.textContent.trim();
        var allLinks = document.querySelectorAll('.navbar-right a, .navbar a');
        for (var i = 0; i < allLinks.length; i++) {
            var href = allLinks[i].getAttribute('href') || '';
            if (href.indexOf('/me') > -1) {
                u = allLinks[i].textContent.trim();
                break;
            }
        }

        var url = W + '/autologin?user=' + encodeURIComponent(u) + '&key=' + encodeURIComponent(K);

        var nav = el.closest('ul') || el.parentElement.parentElement;
        if (nav) {
            var li = document.createElement('li');
            li.innerHTML = '<a href="' + url + '"><span class="glyphicon glyphicon-heart"></span> Wishlist</a>';
            nav.insertBefore(li, nav.firstChild);
        }
    }
    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', go);
    else setTimeout(go, 300);
})();
