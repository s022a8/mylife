//検索フォームに関して
(function() {
    $(function() {
        $('input[name="search"]').change(function() {
            var checking = $(this).val();
            
            if (checking == 'name') {
                $('#names_search').toggleClass('display-none');
                $('#tags_search').toggleClass('display-none');
            } else if (checking == 'tag') {
                $('#tags_search').toggleClass('display-none');
                $('#names_search').toggleClass('display-none');
            } else {
                return;
            }
        });

        // var names_search = document.getElementById('names_search');
        // var tags_search = document.getElementById('tags_search');
        // var search_radio_buttons = document.getElementsByName('search');
        
        // for (var i = 0, len = search_radio_buttons.length; i < len; i++) {
        //     search_radio_buttons.item[i].addEventListener('change', function() {
        //         var checking = this.value;
        //         console.log(checking);
        //     });
        // }

        // search_radio_buttons.addEventListener('change', function() {
        //     var checking = this.value;
        //     console.log(checking);

            // if (checking == 'name') {
            //     names_search.classList.toggle('display-none');
            // } else if (checking == 'tag') {
            //     tags_search.classList.toggle('display-none');
            // } else {
            //     return;
            // }
        // });
    });
})();