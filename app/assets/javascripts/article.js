Articles = {
    init: function(root) {
        Articles.root = root;
        Articles.nav = Articles.root.find("nav");
        Articles.setSection(Articles.root.find("h1, h2, h3"));

        Articles.nav.find("a[href^='#']").on('click', function(event) {
            event.preventDefault();

            $('html, body').animate({
                scrollTop: $($.attr(this, 'href')).offset().top - 100
            }, 500);
        });
    },
    setSection: function(titles) {
        for(var i = 1; i < titles.length; i++) {
            $(titles[i]).attr("id", "part-" + i);
            Articles.nav.append('<a href="#part-' + i + '">' + titles[i].innerText + '</a>');
        }
    }
};

$(document).ready(function() {
    Articles.init($(".article"));
});
