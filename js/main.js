function setColor(pItemID) {
    $('#' + pItemID).removeClass(function (index, className) {
        return (className.match(/(^|\s)u-color-\S+/g) || []).join(' ');
    }).addClass($('#' + pItemID).val() + '-bg');
}

function init(pItemID) {
    // Init subscription after page load
    apex.jQuery(window).on('theme42ready', function () {
        // Run after ui elements rendered on page
        setColor(pItemID);
    })

    // Init onClick event for buttons with attribute data-event
    apex.jQuery('#' + pItemID).on('change', function () {
        setColor(pItemID);
    })
}