function redirect() {
    window.location = 'http://www.nfp.fazenda.sp.gov.br';
}


function inicializarSistema(pagina, nomeJanela) {
    abreJanelaSistema(pagina, nomeJanela);
    self.setTimeout("redirect()", 30000);
}

function abreJanelaSistema(pagina, nomeJanela) {
    var win;
    if ((screen.width>=1024) && (screen.height>=768)) {
        win = window.open(pagina, nomeJanela, 'width=950, height=700, resizable=yes, scrollbars=yes, menubar=no, toolbar=no');
    } else {
        win = window.open(pagina, nomeJanela, 'width=' + (screen.availWidth - 10) + ', height=' + (screen.availHeight - 30) +
            ', resizable=yes, scrollbars=yes, menubar=no, toolbar=no, screenX=0, screenY=0, top=0, left=0');
    }
    win.focus();
}

function abreJanela(pagina, nomeJanela) {
    window.open(pagina, nomeJanela, 'width=800, height=600, location=no,scrollbars=yes,toolbar=no,resizable=yes');
}

function abrePopUp(pagina, nomeJanela) {
    var win;
    win = window.open(pagina, nomeJanela, 'width=640, height=480, location=no,scrollbars=yes,toolbar=no,resizable=yes');
    win.focus();
}

function abrePopUpWH(pagina, nomeJanela, widt, heigh) {
    var win;
    win = window.open(pagina, nomeJanela, 'width=' + widt + ', height=' + heigh + ', location=no,scrollbars=yes,toolbar=no,resizable=yes');
    win.focus();
}

function BotaoDefaultForm(btn) {
    // process only the Enter key
    if (event.keyCode == 13) {
        // cancel the default submit
        event.returnValue = false;
        event.cancel = true;
        // submit the form by programmatically clicking the specified button
        btn.click();
    }
}

function SetFormDefaultField() {
    var bFound = false;
    for (i = 0; i < document.forms[0].length; i++) {
        if (document.forms[0][i].type != "hidden") {
            if (document.forms[0][i].disabled != true) {
                //alert(document.forms[0][i].name);
                document.forms[0][i].focus();
                var bFound = true;
            }
        }
        if (bFound == true)
            break;
    }
}



function showHelp(path) {

    window.open(path, '', 'letf=0,top=0,width=500px,height=280px,toolbar=0,scrollbars=0,status=0');

}

function trim(value) {
    return value.replace(/^\s\s*/, "").replace(/\s\s*$/, "");
}


function ValidateDataCNPJCPFMaster(e) {
    var result = trim(e.value);
    $(e).css("border", "1px solid #ADADAD");

    try {
        if (($("spError")) != null)
            e.parentElement.removeChild(($("spError")));
    }
    catch (err)
    { }

    result = result.replace("-", "");
    result = result.replace("/", "");
    result = result.replace(".", "");
    result = result.replace(".", "");
    result = result.replace(".", "");

    if (result.length == 11) {
        if (VerificaCPFDigito(result))
            //e.style.backgroundColor = "";
            $(e).css("border", "1px solid #ADADAD");
        else {
            //e.focus();
            //e.style.backgroundColor = "#dededc";
            $(e).css("border", "1px solid red");
            $("body").data("errCpfcnpj", "- CPF Inválido. Dígito verificador não confere, favor corrigir!<br/><br/>");
            //e.parentElement.appendChild(CreateErrorElement("(*)Dígito verificador não confere. CPF Inválido favor corrigir!"));
            //e.focus();
        }
    }
    else if (result.length == 14) {
        if (VerificaCNPJDigito(result))
            //e.style.backgroundColor = "";
            $(e).css("border", "1px solid #ADADAD");
        else {
            //e.focus();
            //e.style.backgroundColor = "#dededc";
            $(e).css("border", "1px solid red");
            $("body").data("errCpfcnpj", "- CNPJ Inválido. Dígito verificador não confere, favor corrigir!<br/><br/>" );
            //alert("(*)Dígito verificador não confere. CNPJ Inválido favor corrigir!");
            //e.parentElement.appendChild(CreateErrorElement("(*)Dígito verificador não confere. CNPJ Inválido favor corrigir!"));
            //e.focus();
        }
    }
    else if ((result.length != 14 && result.length != 11) && result != "") {
        //e.focus();
        //e.style.backgroundColor = "#dededc";
        $(e).css("border", "1px solid red");
        $("body").data("errCpfcnpj", "- CPF ou CNPJ Inválido!<br/><br/>");
        //alert("(*)CPF ou CNPJ Inválido!");
        //e.parentElement.appendChild(CreateErrorElement("(*)CPF ou CNPJ Inválido!"));
        //e.focus();
    }
}


function ValidateDataCNPJCPF(e) {
    var result = trim(e.value);
    e.style.backgroundColor = "";

    try
    {
        if (($("spError")) != null)
            e.parentElement.removeChild(($("spError")));
    }
    catch (err)
    {   }

    result = result.replace("-", "");
    result = result.replace("/", "");
    result = result.replace(".", "");
    result = result.replace(".", "");
    result = result.replace(".", "");

    if (result.length == 11) {
        if (VerificaCPFDigito(result))
            e.style.backgroundColor = "";
        else {
            e.focus();
            e.style.backgroundColor = "#dededc";
            alert("(*)Dígito verificador não confere. CPF Inválido favor corrigir!");
            //e.parentElement.appendChild(CreateErrorElement("(*)Dígito verificador não confere. CPF Inválido favor corrigir!"));
            e.focus();
        }
    }
    else if (result.length == 14) {
        if (VerificaCNPJDigito(result))
            e.style.backgroundColor = "";
        else {
            e.focus();
            e.style.backgroundColor = "#dededc";
            alert("(*)Dígito verificador não confere. CNPJ Inválido favor corrigir!");
            //e.parentElement.appendChild(CreateErrorElement("(*)Dígito verificador não confere. CNPJ Inválido favor corrigir!"));
            e.focus();
        }
    }
    else if ((result.length != 14 && result.length != 11) && result != "") {
        e.focus();
        e.style.backgroundColor = "#dededc";
        alert("(*)CPF ou CNPJ Inválido!");
        //e.parentElement.appendChild(CreateErrorElement("(*)CPF ou CNPJ Inválido!"));
        e.focus();
    }
}


function VerificaCNPJDigito(e) {
    var CNPJ = e;
    var a = [];
    var b = new Number;
    var c = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    for (i = 0; i < 12; i++) {
        a[i] = CNPJ.charAt(i);
        b += a[i] * c[i + 1];
    }
    if ((x = b % 11) < 2) { a[12] = 0 } else { a[12] = 11 - x }
    b = 0;
    for (y = 0; y < 13; y++) {
        b += (a[y] * c[y]);
    }
    if ((x = b % 11) < 2) { a[13] = 0; } else { a[13] = 11 - x; }
    if ((CNPJ.charAt(12) != a[12]) || (CNPJ.charAt(13) != a[13]))
        return false;
    else
        return true;
}


function DisabledKeyCopy(objEvent) {
    var pressedKey = String.fromCharCode(objEvent.keyCode).toLowerCase();
    if (event.ctrlKey && (pressedKey == "c" || pressedKey == "v"))
        event.returnValue = false;
}

function SetAutomaticMaskCNPJ(e, objEvent) {
    if ((48 <= objEvent.keyCode && objEvent.keyCode <= 57) ||
       (97 <= objEvent.keyCode && objEvent.keyCode <= 105)) {
        var result = e.value;
        if (result.length > 11 && result.length <= 15) {
            result = trim(e.value).replace("-", "").replace("/", "").replace(".", "").replace(".", "");
            e.value = result.substring(0, 2) + "." + result.substring(2, 5) + "." + result.substring(5, 8) + "/" + result.substring(8, 13) + "-";
        } else if (result.length >= 15) {
            result = trim(e.value).replace("-", "").replace("/", "").replace(".", "").replace(".", "");
            e.value = result.substring(0, 2) + "." + result.substring(2, 5) + "." + result.substring(5, 8) + "/" + result.substring(8, 12) + "-" + result.substring(12, 14);
        }
    }
}