$(function () {
    init_editable_select('.editable-select');

    $(document).on("change", ".guest-list input", function () {
        updateGuest(this, $(this).val().trim());
    });

    $(document).on("change", ".guest-list .editable-select", function() {
        var instances = $(this).parent('td').find('select').editableSelectInstances();
        instances[0].addOption($(this).val().trim());
    });
});

function init_editable_select(selector) {
    $(selector).editableSelect({
        bg_iframe: true,
        onSelect: function () {
            updateGuest(this.text, this.current_value);
        },
        case_sensitive: false,
        items_then_scroll: 10
    });
}

function updateGuest(text, editableContentAfter) {
    var update_url = $(text).parents('tr').find('.guest-update-url').val();
    var guest_attr_to_update = 'guest[' + $(text).parent('td').attr('model-attr') + ']';
    $.ajax({
        url: update_url + '?' + guest_attr_to_update + '=' + editableContentAfter,
        type: 'PUT'
    });
}