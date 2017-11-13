Articles = {
    init: function(root, menuOffset) {
        Articles.root = root;
        Articles.menuOffset = menuOffset;
        Articles.content = Articles.root.find(".article-content");
        Articles.nav = Articles.root.find("nav ul");
        Articles.setSection(Articles.content.find("h1, h2, h3"));

        Articles.nav.find("a[href^='#']").on('click', function(event) {
            event.preventDefault();

            $('html, body').animate({
                scrollTop: $($.attr(this, 'href')).offset().top - Articles.menuOffset
            }, 500);
        });

        $(window).on('scroll', function() {
            Articles.content.find("h1, h2, h3").each(function() {
                if($(window).scrollTop() >= $(this).position().top - Articles.menuOffset) {
                    var id = $(this).attr('id');
                    Articles.nav.find('a').removeClass('current');
                    Articles.nav.find("a[href^='#" + id + "']").addClass('current');
                }
            });
        });
    },
    setSection: function(titles) {
        for(var i = 0; i < titles.length; i++) {
            $(titles[i]).attr("id", "part-" + i);
            Articles.nav.append('<a href="#part-' + i + '">' + titles[i].innerText + '</a>');
        }
    }
};

$(document).ready(function() {
    Articles.init($(".article"), $("header.nav").height());
});
