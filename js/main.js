function setColor(pItemID) {
    $('#' + pItemID).removeClass(function (index, className) {
        return (className.match(/(^|\s)u-color-\S+/g) || []).join(' ');
    }).addClass($('#' + pItemID).val() + '-bg');
}