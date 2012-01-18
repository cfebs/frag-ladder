// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( function () {
    $('.add_player').click( function() {
        //var new_row = $(this).prev('.player_table').next('.player_row').clone(true, true);
        var table = $(this).next('.player_table');
        var new_row = table.find('.player_row').first().clone(true,true);
        var last_row = table.find('.player_row').last();
        new_row.insertAfter(last_row);
    });
});
