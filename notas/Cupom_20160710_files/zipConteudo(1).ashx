function FinalizarSistema() {
    if (confirm("Deseja encerrar esta sessão?")) {
        var urlTokens = String(window.location).split("/");
        if (urlTokens[2] == "www.nfp.fazenda.sp.gov.br")
        {
            window.location = urlTokens[0] + "//" + urlTokens[2] + "/EncerrarSessao.aspx";
        } else
        {
            window.location = urlTokens[0] + "//" + urlTokens[2] + "/" + urlTokens[3] + "/encerrarSessao.aspx";
        }
    }
    return false;
}

function isIE() {
    return (navigator.appName.toUpperCase() == "MICROSOFT INTERNET EXPLORER" ? true : false);
}

function DigitoCPFCNPJ(numCNPJ) 
{
    var numDois = numCNPJ.substring(numCNPJ.length-2, numCNPJ.length);
    var novoCNPJ = numCNPJ.substring(0, numCNPJ.length-2);

    switch (numCNPJ.length)
    {
        case 11 :
            numLim = 11;
            break;
        case 14 :
            numLim = 9;
            break;
        default : return false;
    }

    var numSoma = 0;
    var Fator = 1;
    for (var i=novoCNPJ.length-1; i>=0 ; i--) 
    {
        Fator = Fator + 1;
        if (Fator > numLim) 
        {   
            Fator = 2;
        }
        numSoma = numSoma + (Fator * Number(novoCNPJ.substring(i, i+1)));
    }

    numSoma = numSoma/11;
    var numResto = Math.round( 11 * (numSoma - Math.floor(numSoma)));
    if (numResto > 1) 
    {
        numResto = 11 - numResto;
    }
    else 
    {
        numResto = 0;
    }

//-- Primeiro dígito calculado. Fará parte do novo cálculo.
    var numDigito = String(numResto);
    novoCNPJ = novoCNPJ.concat(numResto);
//--

    numSoma = 0;
    Fator = 1;
    for (var i=novoCNPJ.length-1; i>=0 ; i--) 
    {
        Fator = Fator + 1;
        if (Fator > numLim) 
        {
            Fator = 2;
        }
        numSoma = numSoma + (Fator * Number(novoCNPJ.substring(i, i+1)));
    }
    numSoma = numSoma/11;
    numResto = numResto = Math.round( 11 * (numSoma - Math.floor(numSoma)));
    if (numResto > 1) 
    {
        numResto = 11 - numResto;
    }
    else 
    {
        numResto = 0;
    }

        //-- Segundo dígito calculado.

    numDigito = numDigito.concat(numResto);
    if (numDigito == numDois) 
    {   
        return 0;
    }
    else 
    {
       return 1;
    }
}

function Substitui(CNPJCPF,CharOrg,CharNovo)
{   
    var temp = CNPJCPF;
    var i = temp.indexOf(CharOrg);
    while(i > -1)
    {
        temp = temp.replace(CharOrg, CharNovo);
        i = temp.indexOf(CharOrg, i + CharNovo.length + 1);
    }
    return temp;
}

function VerificaCNPJ(obj)
{ 
    var temp = obj.value;
    temp = Substitui(temp,'.','');
    temp = Substitui(temp,'-','');
    temp = Substitui(temp,'/','');    
    CNPJ = temp;
    if (CNPJ != "") 
    {   RetCritDv = DigitoCPFCNPJ(CNPJ);
        var comp = CNPJ.length;
            
        if ((comp == 11) || (comp == 14))
        {   
            RetCritDv = DigitoCPFCNPJ(CNPJ);
            if (RetCritDv == "1")
            {   
                alert ("CNPJ ou CPF inválido dig invalido");
                obj.value = '';
            }
            else
            {
                if (comp == 11)
                { 
                    obj.value = CNPJ.substring(0,3) + '.' + CNPJ.substring(3,6) + '.' + CNPJ.substring(6,9) + '-' + CNPJ.substring(9,11);
                }
                else
                {
                    if (CNPJ.length == 14)
                    {
                        obj.value = CNPJ.substring(0,2) + '.' + CNPJ.substring(2,5) + '.' + CNPJ.substring(5,8) + '/' + CNPJ.substring(8,12) + '-' + CNPJ.substring(12,14) ;
                    }
                }
            }
        }
        else
        {
            alert("Número de CNPJ ou CPF inválido comp!=11 e 14");
            obj.value = '';
        }                      
    }
}    
                     
function RetiraPlic(objEvent) 
{
    var iKeyCode, strKey;  
    var reinValidChars = /'/;
    var reinValidChars1 = /"/;
                                                
    if (isIE()) 
    {
        iKeyCode = objEvent.keyCode;
    } else 
    {
        iKeyCode = objEvent.which;
    }                                           
    strKey = String.fromCharCode(iKeyCode);

    if (reinValidChars.test(strKey)) 
    {
        return false;
    }
    if (reinValidChars1.test(strKey)) 
    {
        return false;
    }
    if (reinValidChars2.test(strKey)) 
    {
        return false;
    }
}
                                                                        
function SoAceitaNumero(objEvent) 
{
    var iKeyCode, strKey;  
    var reValidChars = /\d/;
    
    if (isIE()) 
    {
        iKeyCode = objEvent.keyCode;
    }
    else 
    {
        iKeyCode = objEvent.which;
    }

    if ((iKeyCode == 8) ||
        (iKeyCode == 0)) { // Trata as teclas delete, backspace e setas
        return true;
    }
    
    strKey = String.fromCharCode(iKeyCode);
    if (!reValidChars.test(strKey)) 
    {
        return false;
    } else {
        return true;
    }
}

function SoAceitaNumero2(objEvent) 
{
    var iKeyCode, strKey;  
    var reValidChars = /\d/;
    
    if (isIE()) 
        iKeyCode = objEvent.keyCode;
    else 
        iKeyCode = objEvent.which;
    
    strKey = String.fromCharCode(iKeyCode);
    if (!reValidChars.test(strKey)) 
        objEvent.keyCode = 0;
}



function FormataData(campo,teclapres) 
{
    var tecla = teclapres.keyCode;
    vr = campo.value;
    vr = vr.replace( ".", "" );
    vr = vr.replace( "/", "" );
    vr = vr.replace( "/", "" );
    tam = vr.length + 1;

    if ( tecla != 9 && tecla != 8 )
    {
        if ( tam > 2 && tam < 5 )
        {
            campo.value = vr.substr( 0, tam - 2  ) + '/' + vr.substr( tam - 2, tam );
        }

        if ( tam >= 5 && tam <= 10 )
        {
            campo.value = vr.substr( 0, 2 ) + '/' + vr.substr( 2, 2 ) + '/' + vr.substr( 4, 4 );
        } 
    }
}


function validarDataMaster(campo) {
    if (campo.value != "") {
        var expReg = /^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[1-2][0-9]\d{2})$/;
        $(campo).css("border", "1px solid #ADADAD");
        if ((campo.value.match(expReg)) && (campo.value != '')) {
            var dia = campo.value.substring(0, 2);
            var mes = campo.value.substring(3, 5);
            var ano = campo.value.substring(6, 10);
            if (dia == "00") {
                alert("Data inválida.");
                campo.value = "";
                return false;
            }
            if (mes == "00") {
                alert("Data inválida.");
                campo.value = "";
                return false;
            }
            if ((mes == 4 || mes == 6 || mes == 9 || mes == 11) && (dia > 30)) {
                $("body").data("errDate", "-  Dia incorreto. O mês especificado contém no máximo 30 dias.<br/><br/>");
                campo.value = "";
                $(campo).css("border", "1px solid red");
                return false;
            }
            else {
                if ((ano % 4 != 0 && mes == 2) && (dia > 28)) {
                    $("body").data("errDate", "- Data incorreta. O mês especificado contém no máximo 28 dias.<br/><br/>");
                    $(campo).css("border", "1px solid red");
                    campo.value = "";
                    return false;
                }
                else {
                    if ((ano % 4 == 0 && mes == 2) && (dia > 29)) {
                        $("body").data("errDate", "- Data incorreta. O mês especificado contém no máximo 29 dias.<br/><br/>");
                        campo.value = "";
                        $(campo).css("border", "1px solid red");
                        return false;
                    }
                    else {
                        return true;
                    }
                }
            }
        }
        else {
            $("body").data("errDate", "- Data inválida.<br/><br/>");
            $(campo).css("border", "1px solid red");
            campo.value = "";
            return false;
        }
    }
}

function validarData(campo)
{
if (campo.value != "")
{
            var expReg = /^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[1-2][0-9]\d{2})$/;
            var msgErro = 'Data inválida.';
            if ((campo.value.match(expReg)) && (campo.value!=''))
                    {
                    var dia = campo.value.substring(0,2);
                    var mes = campo.value.substring(3,5);
                    var ano = campo.value.substring(6, 10);
                    if (dia == "00") {
                        alert("Data inválida.");
                        campo.value = "";
                        return false;
                    }
                    if (mes == "00") {
                        alert("Data inválida.");
                        campo.value = "";
                        return false;
                    }
                    if ((mes==4 || mes==6 || mes==9 || mes==11) && (dia > 30)){
                        alert("Dia incorreto !!! O mês especificado contém no máximo 30 dias.");
                        campo.value = "";
                        return false;
                    } 
                    else
                    {
                      if ((ano%4!=0 && mes==2) && (dia>28))
                      {
                        alert("Data incorreta!! O mês especificado contém no máximo 28 dias.");
                        campo.value = "";
                        return false;
                      } 
                      else
                      {
                      if ((ano%4==0 && mes==2) && (dia>29))
                       {
                       alert("Data incorreta!! O mês especificado contém no máximo 29 dias.");
                       campo.value = "";
                       return false;
                       }
                       else
                       { 
                    return true;
                      }
                    }
                }
            } 
        else 
        {
            alert(msgErro);
            campo.value = "";
            return false;
        }
    }
}

function FormataMesAno(campo,teclapres) 
{
     var tecla = teclapres.keyCode;
     vr = campo.value;
     vr = vr.replace(".", "");
     vr = vr.replace("/", "");
     tam = vr.length + 1;

     if (tecla != 9 && tecla != 8)
     {
         if ( tam > 2)
         {
             campo.value = vr.substr(0, 2) + '/' + vr.substr(2, tam );
         } 
     }
 }



function ValidarMesAno(campo)
{
    if (campo.value != "")
    {
        var expReg = /^([0]\d|[1][0-2])\/[1-2][0-9]\d{2}$/;
        var msgErro = 'Data inválida.';
        if ((campo.value.match(expReg)) && (campo.value!=''))
        {
            return true;
        } 
        else 
        {
            alert(msgErro);
            campo.value = "";
            return false;
        }
    }
}

function FormataValor(campo,tammax,teclapres) {

 

             var tecla = teclapres.keyCode;

             vr = campo.value;

             vr = vr.replace( "/", "" );

             vr = vr.replace( "/", "" );

             vr = vr.replace( ",", "" );

             vr = vr.replace( ".", "" );

             vr = vr.replace( ".", "" );

             vr = vr.replace( ".", "" );

             vr = vr.replace( ".", "" );

             tam = vr.length;

 

             if (tam < tammax && tecla != 8){ tam = vr.length + 1 ; }

 

             if (tecla == 8 ){   tam = tam - 1 ; }

                          

             if ( tecla == 8 || tecla >= 48 && tecla <= 57 || tecla >= 96 && tecla <= 105 ){

                          if ( tam <= 2 ){ 

                                       campo.value = vr ; }

                          if ( (tam > 2) && (tam <= 5) ){

                                       campo.value = vr.substr( 0, tam - 2 ) + ',' + vr.substr( tam - 2, tam ) ; }

                          if ( (tam >= 6) && (tam <= 8) ){

                                       campo.value = vr.substr( 0, tam - 5 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }

                          if ( (tam >= 9) && (tam <= 11) ){

                                       campo.value = vr.substr( 0, tam - 8 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }

                          if ( (tam >= 12) && (tam <= 14) ){

                                       campo.value = vr.substr( 0, tam - 11 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }

                          if ( (tam >= 15) && (tam <= 17) ){

                                       campo.value = vr.substr( 0, tam - 14 ) + '.' + vr.substr( tam - 14, 3 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ;}

             }

}
function FormataCNPJ(campo,teclapres) 
{
    var tecla = teclapres.keyCode;
    vr = campo.value;
    vr = vr.replace( ".", "" );
    vr = vr.replace( ".", "" );
    vr = vr.replace( "/", "" );
    vr = vr.replace( "-", "" );
    tam = vr.length + 1;

    if ( tecla != 9 && tecla != 8 )   //delete, backspace
    {
        if ( tam > 2 && tam < 6 )
        {
            campo.value = vr.substr( 0, tam - 2  ) + '.' + vr.substr( tam - 2, tam );
        }

        if ( tam >= 6 && tam <= 10 )
        {
            campo.value = vr.substr( 0, 2 ) + '.' + vr.substr( 2, 3 ) + '.' + vr.substr( 5, 3 );
        } 
        if ( tam >= 9 && tam <= 13 )
        {
            campo.value = vr.substr( 0, 2 ) + '.' + vr.substr( 2, 3 ) + '.' + vr.substr( 5, 3 ) + '/' + vr.substr(8,4);
        } 
        if ( tam >= 13 && tam <= 14 )
        {
            campo.value = vr.substr( 0, 2 ) + '.' + vr.substr( 2, 3 ) + '.' + vr.substr( 5, 3 ) + '/' + vr.substr(8,4) + '-'+ vr.substr(12,2);
        } 
    }
}
function FormataCPF(campo,teclapres) 
{
    var tecla = teclapres.keyCode;
    vr = campo.value;
    vr = vr.replace( ".", "" );
    vr = vr.replace( ".", "" );
    vr = vr.replace( "-", "" );
    tam = vr.length + 1;

    if ( tecla != 9 && tecla != 8 )   //delete, backspace
    {
        if ( tam > 2 && tam < 7 )
        {
            campo.value = vr.substr( 0, tam - 3  ) + '.' + vr.substr( tam - 3, tam );
        }

        if ( tam >= 7 && tam <= 10 )
        {
            campo.value = vr.substr( 0, 3 ) + '.' + vr.substr( 3, 3 ) + '.' + vr.substr( 6, 3 );
        } 
        if ( tam >= 10 && tam <= 11 )
        {
            campo.value = vr.substr( 0, 3 ) + '.' + vr.substr( 3, 3 ) + '.' + vr.substr( 6, 3 ) + '-' + vr.substr(9,2);
        }
    }
}

function FormataCPFouCNPJ(campo, teclapres) {
    var tecla = teclapres.keyCode;
    if (tecla != 13 && tecla != 9 && tecla != 8) {
        vr = campo.value;
        vr = vr.replace(".", "");
        vr = vr.replace(".", "");
        vr = vr.replace("/", "");
        vr = vr.replace("-", "");
        vr = vr.replace(".", "");
        vr = vr.replace("-", "");
        tam = vr.length + 1;
        if ( tam >= 2 && tam <= 11 )
            FormataCPF(campo, teclapres)
        else
            FormataCNPJ(campo, teclapres)
    }
}

function FormataCEP(campo,teclapres) 
{
    var tecla = teclapres.keyCode;
    vr = campo.value;
    vr = vr.replace( "-", "" );
   tam = vr.length + 1;

    if ( tecla != 9 && tecla != 8 )   //delete, backspace
    {
        if ( tam > 5 && tam < 9 )
        {
            campo.value = vr.substr( 0, tam - 3  ) + '-' + vr.substr( tam - 3, tam );
        }
    }
}
function FormataHora(campo,teclapres) 
{
    var tecla = teclapres.keyCode;
    vr = campo.value;
    vr = vr.replace( ".", "" );
    vr = vr.replace( ":", "" );
    tam = vr.length + 1;

    if ( tecla != 9 && tecla != 8 )
    {
        if ( tam > 2 && tam < 5 )
        {
            campo.value = vr.substr( 0, tam - 2  ) + ':' + vr.substr( tam - 2, tam );
        }
    }
}
function FormataFone(campo,teclapres) 
{
    var tecla = teclapres.keyCode;
    vr = campo.value;
    /*vr = vr.replace( ".", "" );*/
    vr = vr.replace( "-", "" );
    tam = vr.length + 1;

    if ( tecla != 9 && tecla != 8 )
    {
        if ( tam > 4 && tam < 9 )
        {
            campo.value = vr.substr( 0, tam - 4  ) + '-' + vr.substr( tam - 4, tam );
        }
    }
}

/// Função que limita o número de caracteres em uma text area
function TextAreaMaxLength(field, maxlimit)
{
	if (field.value.length > maxlimit) field.value = field.value.substring(0, maxlimit);
}

function ValidatorFieldToFilter(ctlMunicipio, ctlLogradouro, ctlNomeFornecedor) {
    var $fornecedor = $('#' + ctlNomeFornecedor);
    var $logradouro = $('#' + ctlLogradouro);

    var onlyAddress = trim($fornecedor.val()) == '';

    if (onlyAddress) {
        $logradouro.removeAttr('disabled');
        $logradouro.css('backgroundColor', '#ffffff');
    } else {
        $logradouro.attr('disabled', 'disabled');
        $logradouro.css('backgroundColor', '#dededc');
        $logradouro.val('');
    }
}

function ValidatorFieldToFilterAddress(ctlMunicipio, ctlLogradouro, ctlNomeFornecedor) {
    var $fornecedor = $('#' + ctlNomeFornecedor);
    var $logradouro = $('#' + ctlLogradouro);

    var onlyAddress = trim($logradouro.val()) != '';

    if (onlyAddress) {
        $fornecedor.attr('disabled', 'disabled');
        $fornecedor.css('backgroundColor', '#dededc');
        $fornecedor.val('');
        $logradouro.css('backgroundColor', '#ffffff');
    } else {
        $fornecedor.removeAttr('disabled');
        $fornecedor.css('backgroundColor', '#ffffff');
    }
}




function CalculaDigitoCFeSAT(ChavAcess) {
    var soma = 0;
    for (i = 42; i >= 0; i--) {
        for (y = 2; y <= 9 && i >= 0; y++) {
            soma = soma + (ChavAcess.charAt(i) * y);
            if (y < 9 && i >= 0)
                i--;
        }
    }
    var digito = soma % 11;
    if (digito == 0 || digito == 1)
        digito = 0;
    else
        digito = 11 - digito;
    if (digito == ChavAcess.charAt(43))
        return true;
    else {
        return false;
    }
}

function FormatarValorDeString(num) {
    var num = num / 100;
    var numParts = parseFloat(num).toFixed(2).split('.');
    var qtdMil = Math.floor(numParts[0].length / 3);
    var i, posMil, frmtd = "";
    for (i = 1; i <= qtdMil; i++) {
        posMil = (numParts[0].length - (i * 3));
        frmtd = "." + numParts[0].slice(posMil, posMil + 3) + frmtd;
    }
    frmtd = numParts[0].slice(0, posMil) + frmtd;
    frmtd = frmtd.charAt(0) == "." ? frmtd.substring(1, frmtd.length) : frmtd;
    frmtd = frmtd + "," + numParts[1];
    return frmtd;
}