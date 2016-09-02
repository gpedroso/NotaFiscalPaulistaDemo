$(function () {
    //Exibir Access Key
    $(document).keydown(function (event) {
        if (event.altKey) {
            $('.accessKey').show();
        }
    });

    $(document).keyup(function (event) {
        if (event.altKey) {
            //Numero 1 - Inicio
            if (event.keyCode == 49 || event.keyCode == 97) {
                $('#MenuSuperior li').each(function () {
                    Sys.WebForms.Menu._domHelper.removeEvent(this, 'mouseover', Sys.WebForms.MenuItem._onmouseover);
                    Sys.WebForms.Menu._domHelper.removeEvent(this, 'mouseout', Sys.WebForms.MenuItem._onmouseout);
                    //Sys.WebForms.Menu._domHelper.removeEvent(this, 'focus', Sys.WebForms._MenuContainer.prototype._onfocus, true);
                    //Sys.WebForms.Menu._domHelper.removeEvent(this, 'keydown', Sys.WebForms._MenuContainer.prototype._onkeydown);
                });
                $('#MenuSuperior ul').show();
                //Numero 1 - Fim

            } else if (event.keyCode == 50 || event.keyCode == 98) {
                //Numero 2 - Inicio

               // $('#ConteudoPrincipal').focus();
                //window.scrollTo(new_position.left, new_position.top);

                //location.href = location.href + '#ConteudoPrincipal';
                location.hash = '#MenuSuperior';



                //Numero 2 - Fim
            } else if (event.keyCode == 51 || event.keyCode == 99) {
                //Numero 3 - Inicio

               // $('#ConteudoPrincipal').focus();
                //window.scrollTo(new_position.left, new_position.top);

                //location.href = location.href + '#ConteudoPrincipal';
                location.hash = '#ConteudoPrincipal';



                //Numero 3 - Fim
            }
        }
        $('.accessKey').hide();
    });
});