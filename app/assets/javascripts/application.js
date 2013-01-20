// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$(document).ready(function () {
    $(".editable-text").click(function () {
        var before = $.trim($(this).html());
        editEditableText($(this));
    });
});


/*Edit table content*/

function editEditableText(text) {
    var editableSelect = $(text).parent().find(".editable-select");
    var editableInput = $(text).parent().find("input");
    $(text).addClass("hidden");
    if ($(editableSelect).length) {
        editEditableSelect($(editableSelect), $(text));
    }
    else {
        var editableContentBefore = $.trim(text.html());
        $(editableInput).val(editableContentBefore);
        $(editableInput).removeClass("hidden");
        rememberContentFromContainer($(text), $(editableInput));
    }
}

function editEditableSelect(select, text) {
    $(select).removeClass("hidden").focus();
    var editableInput = $(select).parent().find("input");
    rememberContentFromContainer($(text), $(select));
    $(select).change(function () {
        var selectedOption = $(this).find(":selected");
        if ($(selectedOption).hasClass("add_new_value")) {
            $(select).addClass("hidden");
            $(text).addClass("hidden");
            $(editableInput).removeClass("hidden");
            rememberContentFromContainer($(text), $(editableInput));
        }
        else{
            rememberContentFromContainer($(text), $(select));
        }
    });
}

function rememberContentFromContainer(text, container){
    $(container).focus().blur(function () {
        var editableContentBefore = $.trim($(text).html());
        var editableContentAfter = $(container).val();
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
