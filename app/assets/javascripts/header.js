
//ヘッダーに関して
(function() {
    $(function() {
        $(".header-nav-div").mouseover(function() {
            $(this).css({
                'backgroundColor':'rgba(114, 195, 206, 0.2)'
            });
        });

        $(".header-nav-div").mouseout(function() {
            $(this).css({
                'backgroundColor':'white'
            });
        });
    });

})();