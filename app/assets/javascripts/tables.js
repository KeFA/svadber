var editableSelect;
var editableInput;
var editableContentAfter;
var editableContentBefore;

$(document).ready(function () {
    $("[rel='tooltip']").tooltip();

});

$(document).on("click", ".editable-text", function () {
    setTextInTableEditable($(this));
});

$(document).on("mouseenter", "[rel='tooltip']", function () {
    $(this).tooltip();
});


/*Edit table content*/

function setTextInTableEditable(text) {
    editableSelect = $(text).parent().find(".editable-select");
    editableInput = $(text).parent().find("input");
    $(text).addClass("hidden");
    if ($(editableSelect).length) {
        setSelectInTableEditable($(editableSelect), $(text));
    }
    else {
        editableContentBefore = $.trim(text.html());
        $(editableInput).val(editableContentBefore);
        rememberContentFromContainer($(text), $(editableInput));
    }
}

function setSelectInTableEditable(select, text) {
    $(select).removeClass("hidden");
    editableInput = $(select).parent().find("input");
    $(select).change(function () {
        var selectedOption = $(this).find(":selected");
        if ($(selectedOption).hasClass("add_new_value")) {
            $(select).addClass("hidden");
            $(text).addClass("hidden");
            $(editableInput).removeClass("hidden");
            rememberContentFromContainer($(text), $(editableInput));
        }
        else {
            rememberContentFromContainer($(text), $(select));
        }
    });
}

function rememberContentFromContainer(text, container) {
    $(text).addClass("hidden");
    $(container).removeClass("hidden");
    $(container).focus().blur(function () {
        editableContentBefore = $.trim($(text).html());
        editableContentAfter = $(container).val();
        $(text).html(editableContentAfter);
        $(container).addClass("hidden");
        $(text).removeClass("hidden");

        if (editableContentBefore != editableContentAfter) {
            updateGuest(text, editableContentAfter);
        }
    });
}

function updateGuest(text, editableContentAfter) {
    var update_url = $(text).parents('tr').find('.guest-update-url').val();
    var guest_attr_to_update = 'guest[' + $(text).attr('model-attr') + ']';
    $.ajax({
        url: update_url + '?' + guest_attr_to_update + '=' + editableContentAfter,
        type: 'PUT'
    });
}