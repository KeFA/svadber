var do_on_load = function() {
    init_editable_select('.editable-select');

    $(document).on("change", ".guest-list .editable-select", function() {
        var instances = $(this).parent('td').find('select').editableSelectInstances();
        instances[0].addOption($(this).val().trim());
    });
};

$(document).ready(do_on_load);
$(window).on('page:change', do_on_load);

function init_editable_select(selector) {
    /*$(selector).editableSelect({
        bg_iframe: true,
        onSelect: function () {
            updateModel(this.text, this.current_value);
        },
        case_sensitive: false,
        items_then_scroll: 10
    });*/
}