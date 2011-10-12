$(function() {
    $('.auto-submit-star').rating({

        callback: function(value, link) {
            // 'this' is the hidden form element holding the current value
            // 'value' is the value selected
            // 'element' points to the link element that received the click.
//            alert(this.form);
            // To submit the form automatically:
            //this.form.submit();

            // To submit the form via ajax:
//                $(this.form).ajaxSubmit();

            $(this.form).trigger('submit.rails')

//RYAN OBEROI: A big hack, since the cancel callback does not have the appropriate information
//            name = $(this).parent().next().attr('name')

// click callback, as requested here: http://plugins.jquery.com/node/1655
//            if (control.callback) control.callback.apply(input[0], [input.val(), $('a', control.current)[0], name]);// callback event

        }
    });
});


$(document).ready(function() {
    $(".movie-card-poster").hover(function() {
        $(this).find('.movie-card-poster-over').first().show()
    }, function() {
        $(this).find('.movie-card-poster-over').first().hide()
    });
});



