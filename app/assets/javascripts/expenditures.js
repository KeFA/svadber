var do_on_load = function() {

};

$(document).ready(do_on_load);
$(window).on('page:change', do_on_load);

$(document).on("change", ".expenditure_money", function() {
    var tr = $(this).parents('tr');
    var cost = tr.find("[model-attr='cost']").find('input').val();
    var paid = tr.find("[model-attr='paid']").find('input').val();
    tr.find('.remain_to_paid').html(cost - paid);
});