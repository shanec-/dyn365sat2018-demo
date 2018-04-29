﻿if (nfx === undefined) {
    var nfx = {};
}

nfx.displayIconTooltip = function (rowData, userLCID) {
    var str = JSON.parse(rowData);
    var coldata = str.statuscode;
    var imgName = "";
    var tooltip = "";
    switch (coldata) {
        case 224820001:
            imgName = "nfx_/Booking/Images/status_approved.png";
            tooltip = "Approved";
            break;
        case 1:
            imgName = "nfx_/Booking/Images/status_pending.png";
            tooltip = "Pending Approval";
            break;
        case 2:
            imgName = "nfx_/Booking/Images/status_rejected.png";
            tooltip = "Reject";
            break;
        case 224820002:
            imgName = "nfx_/Booking/Images/status_suspending.png";
            tooltip = "Suspended";
            break;
        default:
            imgName = "";
            tooltip = "";
            break;
    }
    var resultarray = [imgName, tooltip];
    return resultarray;
 }  