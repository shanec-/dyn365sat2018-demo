﻿if (nfx === undefined) {
    var nfx = {};
}

nfx.FormLoad = function () {
    if (Xrm.Page.ui.getFormType() == 1) {
        nfx.SetBookingDateToday();
    }
}

nfx.SetBookingDateToday = function () {
    var bookingDate = Xrm.Page.getAttribute("nfx_bookingdate");
    if (bookingDate) {
        bookingDate.setValue(Date.now());
    }
}
