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

$(document).on("change", "table input", function () {
    updateModel(this, $(this).val().trim());
});

function setTextInTableEditable(text) {
    editableInput = $(text).parent().find("input");
    $(text).addClass("hidden");
    editableContentBefore = $.trim(text.html());
    $(editableInput).val(editableContentBefore);
    rememberContentFromContainer($(text), $(editableInput));
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
    });
}


function updateModel(text, editableContentAfter) {
    var update_url = $(text).parents('tr').find('.model_update_url').val();
    var model_name = $(text).parents('tr').find('.model_name').val();
    var model_attr_to_update = model_name + '[' + $(text).parent('td').attr('model-attr') + ']';
    $.ajax({
        url: update_url + '?' + model_attr_to_update + '=' + editableContentAfter,
        type: 'PUT'
    });
}