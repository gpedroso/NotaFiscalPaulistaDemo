/***************************************  HELP **********************************************/

var offsetxpoint = -60;  //Customiza x offset
var offsetypoint = 20;  //Customiza y offset
var ie = document.all;
var ns6 = document.getElementById && !document.all;
var enabletip = false;
var tipobj = null;

$(function () {
    if (ie || ns6)
        tipobj = (document.all) ? document.all["tooltip"] : ((document.getElementById) ? document.getElementById("tooltip") : "");

    document.onmousemove = positiontip;
});

function ietruebody() {
    return (document.compatMode && document.compatMode != "BackCompat") ? document.documentElement : document.body;
}

function ExibeDetalhe(thetext) {
    thecolor = '#EEEEEE';
    thewidth = 400;
    if (ns6 || ie) {
        if (typeof thewidth != "undefined") tipobj.style.width = thewidth + "px";
        if (typeof thecolor != "undefined" && thecolor != "") tipobj.style.backgroundColor = thecolor;
        tipobj.innerHTML = thetext;
        enabletip = true; // para funcionar, coloque TRUE
        return false
    }
}

function positiontip(e) {
    if (enabletip) {
        var curX = (ns6) ? e.pageX : event.clientX + ietruebody().scrollLeft;
        var curY = (ns6) ? e.pageY : event.clientY + ietruebody().scrollTop;
        var rightedge = ie && !window.opera ? ietruebody().clientWidth - event.clientX - offsetxpoint : window.innerWidth - e.clientX - offsetxpoint - 20;
        var bottomedge = ie && !window.opera ? ietruebody().clientHeight - event.clientY - offsetypoint : window.innerHeight - e.clientY - offsetypoint - 20;

        var leftedge = (offsetxpoint < 0) ? offsetxpoint * (-1) : -1000;
        if (rightedge < tipobj.offsetWidth)
            tipobj.style.left = ie ? ietruebody().scrollLeft + event.clientX - tipobj.offsetWidth + "px" : window.pageXOffset + e.clientX - tipobj.offsetWidth + "px";
        else if (curX < leftedge)
            tipobj.style.left = "5px";
        else
            tipobj.style.left = curX + offsetxpoint + "px";

        //same concept with the vertical position
        if (bottomedge < tipobj.offsetHeight)
            tipobj.style.top = ie ? ietruebody().scrollTop + event.clientY - tipobj.offsetHeight - offsetypoint + "px" : window.pageYOffset + e.clientY - tipobj.offsetHeight - offsetypoint + "px";
        else
            tipobj.style.top = curY + offsetypoint + "px";
        tipobj.style.visibility = "visible";
    }
}

function EscondeAjuda() {
    if (ns6 || ie) {
        enabletip = false;
        tipobj.style.visibility = "hidden";
        tipobj.style.left = "-1000px";
        tipobj.style.backgroundColor = '';
        tipobj.style.width = '';
    }
}