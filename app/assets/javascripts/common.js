function isTouchDevice() {
    if ('ontouchstart' in window) {
        $(".no-touch").addClass("touch").removeClass("no-touch");
    };
};

isTouchDevice();