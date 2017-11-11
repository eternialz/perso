Articles = {
    init: function(root) {
        Articles.root = root;
        Articles.setSection(Articles.root.find("h1, h2, h3"));
        console.log("test");
    },
    setSection: function(titles) {
        for(var i = 1; i < titles.length; i++) {
            $(titles[i]).attr("id", "part-" + i);
            Articles.root.find("nav").append('<a href="#part-' + i + '">' + titles[i].innerText + '</a>');
        }
    }
};

$(document).ready(function() {
    Articles.init($(".article"));
});
