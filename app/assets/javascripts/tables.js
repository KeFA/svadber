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