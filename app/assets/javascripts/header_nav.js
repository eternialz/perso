Menu = {
    init: function(root) {
        Menu.root = root;

        if (Menu.root.hasClass('transparent')) {
            $(document).on('scroll', function() {
                Menu.toggleTransparency();
            });

            Menu.toggleTransparency()
        }
    },
    toggleTransparency: function(titles) {
        if ($(document).scrollTop() > 10) {
            Menu.root.removeClass('transparent');
        } else {
            Menu.root.addClass('transparent');
        }
    }
};

$(document).ready(function() {
    Menu.init($("header.nav"));
});
