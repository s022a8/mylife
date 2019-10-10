// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


//コメント欄に関して
(function() {
    $(document).on('turbolinks:load', function() {
        var comment_trriger = document.getElementById('comment_trriger');
        var comment_area = document.getElementById('comment_area');

        comment_trriger.addEventListener('click', function() {
            comment_area.classList.toggle('show');
        });

        comment_trriger.addEventListener('mouseover', function() {
            this.style.backgroundColor = "rgba(34, 179, 224, 0.188)";
        });

        comment_trriger.addEventListener('mouseout', function() {
            this.style.backgroundColor = "white";
        });
    });
})();
