close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino variables publicas
public pan3:={}
public campo:={}
public cadena:=""
public n:={}
public x:={}
public tcla:={}
public marc:={}

//// defino variables claves
tcla=0
N=1
confirmo=.t.
marc=0
set cursor off
mensa="<< Abriendo Maestro de Articulos y respectivos กndices >>"
col=40-(int(len(mensa))/2)
set color to n/w*
@ 16,col say mensa
//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use maeart
        set index to maeart_c,maeart_n
select 2
        use t_fabr
        set index to x_fabr
select 3
        use t_rubr
        set index to x_rubr
select 4
        use t_tipo
        set index to x_tipo
//////////////////////////////// FIN DE LOS SELECT'S

select 1
color="N"    // color blanco de fondo
recuadro=1   // sin recuadro
doble=0      // sin tipo de linea
menuv=0      // sin menu ppal
#include "fondo2.prg"
set color to w+/bg
@ 1,0 say "[Esc=Vuelve]                                                    Fecha:  /  /    "
@ 1,70 say date()
set color to
set cursor on
t="ด Listado de Cartuchos ร"
cx=40-(int(len(t))/2)
@ 2,cx say t
do while .t.
        set filter to
        @ 9,19 to 15,34 double
        @ 10,20 prompt " x CODIGO     "
        @ 11,20 prompt " x NOMBRE     "
        @ 12,20 prompt " x FABRICANTE "
        @ 13,20 prompt " x RUBRO      "
        @ 14,20 prompt " x TIPO JUEGO "
        menu to orden
        sxs:=savescreen(3,1,23,78)
        if lastkey()=27
                return
        endif           
        do case
                case orden=1
                        set index to maeart_c
                case orden>1
                        set index to maeart_n
        endcase
        @ 9,2 clear to 12,70
        if orden=1
                @ 5,1 clear to 22,78
                go top
                d_cod=nroart
                x1=d_cod
                go bottom
                h_cod=nroart
                x2=h_cod
                go top
                @ 3,5 say "Desde codigo:" get d_cod picture "99999"
                @ 4,5 say "Hasta codigo:" get h_cod picture "99999"
                read
                if lastkey()=27
                        inkey()
                else
                        if (d_cod<1 .or. h_cod>99999) .or. (h_cod<d_cod) .or. (d_cod=0 .or. h_cod=0)
                                errorc()
                        else
                                go top
                                if x1=d_cod .and. x2=h_cod
                                        inkey()
                                else
                                        set filter to nroart>=d_cod .and. nroart<=h_cod
                                        copy to artaux
                                endif
                                set color to w/n*
                                set cursor off
                                @ 10,24 say "IMPRIMIENDO LISTADO, AGUARDE"
                                set color to 
                                do while .t.
                                        if isprinter()=.t.
                                                set device to printer
                                                imprimec()
                                                exit
                                        else
                                                set device to screen
                                                set color to gr+/b*
                                                set cursor off
                                                impx:=savescreen(16,1,16,78)
                                                @ 16,15 say "ญญ PRENDA LA IMPRESORA Y DESPUES PULSE UNA TECLA !!"
                                                inkey(0)
                                                if lastkey()=27
                                                        return
                                                endif
                                                set color to 
                                                set cursor on
                                                restscreen(16,1,16,78,impx)
                                        endif
                                enddo
                                set cursor on
                                set device to screen
                                @ 10,24 say "                            "
                         endif
                endif
        elseif orden=2
                @ 5,1 clear to 22,78
                d_cod="A"
                h_cod="Z"
                go top
                @ 3,5 say "Desde letra:" get d_cod picture "!"
                @ 4,5 say "Hasta letra:" get h_cod picture "!"
                read
                if lastkey()=27
                        inkey()
                else
                        if (d_cod<"A" .or. h_cod>"Z") .or. (h_cod<d_cod)
                                errorc()
                        else
                                go top
                                if d_cod="A" .and. h_cod="Z"
                                        inkey()
                                else
                                        set filter to (d_cod=left(nomart,1) .or. d_cod<left(nomart,1)) .and. (h_cod=left(nomart,1) .or. h_cod>left(nomart,1))
                                        copy to artaux
                                endif
                                set color to w/n*
                                set cursor off
                                @ 10,24 say "IMPRIMIENDO LISTADO, AGUARDE"
                                set color to 
                                do while .t.
                                        if isprinter()=.t.
                                                set device to printer
                                                imprimec()
                                                exit
                                        else
                                                set device to screen
                                                set color to gr+/b*
                                                set cursor off
                                                impx:=savescreen(16,1,16,78)
                                                @ 16,15 say "ญญ PRENDA LA IMPRESORA Y DESPUES PULSE UNA TECLA !!"
                                                inkey(0)
                                                if lastkey()=27
                                                        return
                                                endif
                                                set color to 
                                                set cursor on
                                                restscreen(16,1,16,78,impx)
                                        endif
                                enddo
                                set cursor on
                                set device to screen
                                @ 10,24 say "                            "
                         endif
                endif
        elseif orden>2
                do case
                        case orden=3
                                select 2
                                tapan=savescreen(0,0,24,80)
                                to=lastrec()
                                if to=0 
                                        xp=savescreen (0,0,24,80)
                                        set color to w+/n*
                                        set cursor off
                                        men=" << Falta cargar la tabla >> "
                                        @ 5,49 say men
                                        set color to
                                        @ 4,59 say replicate ("อ",19)
                                        inkey(3)
                                        set cursor on
                                        restscreen (0,0,24,80,xp)
                                        set key K_F2 to btablaart()
                                        return
                                endif
                                declare tp[to]
                                declare tp2[to]
                                declare tp3[to]
                                go top
                                for xa=1 to to
                                        cad=str(codigo)+" ณ "+descri
                                        tp[xa]=cad
                                        tp2[xa]=codigo
                                        tp3[xa]=descri
                                        skip
                                next xa
                                @ 9,9 clear to 13,41 
                                @ 9,9 to 13,41 double
                                fa=achoice(10,10,12,40,tp)
                                if lastkey()<>27
                                        select 1
                                        go top
                                        set filter to fa=fabart
                                        copy to artaux
                                endif
                        case orden=4
                                select 3
                                tapan=savescreen(0,0,24,80)
                                to=lastrec()
                                if to=0 
                                        xp=savescreen (0,0,24,80)
                                        set color to w+/n*
                                        set cursor off
                                        men=" << Falta cargar la tabla >> "
                                        @ 5,49 say men
                                        set color to
                                        @ 4,59 say replicate ("อ",19)
                                        inkey(3)
                                        set cursor on
                                        restscreen (0,0,24,80,xp)
                                        set key K_F2 to btablaart()
                                        return
                                endif
                                declare tp[to]
                                declare tp2[to]
                                declare tp3[to]
                                go top
                                for xa=1 to to
                                        cad=str(codigo)+" ณ "+descri
                                        tp[xa]=cad
                                        tp2[xa]=codigo
                                        tp3[xa]=descri
                                        skip
                                next xa
                                @ 9,9 clear to 13,41 
                                @ 9,9 to 13,41 double
                                ru=achoice(10,10,12,40,tp)
                                if lastkey()<>27
                                        select 1
                                        go top
                                        set filter to ru=rubart
                                        copy to artaux
                                endif
                        case orden=5
                                select 4
                                tapan=savescreen(0,0,24,80)
                                to=lastrec()
                                if to=0 
                                        xp=savescreen (0,0,24,80)
                                        set color to w+/n*
                                        set cursor off
                                        men=" << Falta cargar la tabla >> "
                                        @ 5,49 say men
                                        set color to
                                        @ 4,59 say replicate ("อ",19)
                                        inkey(3)
                                        set cursor on
                                        restscreen (0,0,24,80,xp)
                                        set key K_F2 to btablaart()
                                        return
                                endif
                                declare tp[to]
                                declare tp2[to]
                                declare tp3[to]
                                go top
                                for xa=1 to to
                                        cad=str(codigo)+" ณ "+descri
                                        tp[xa]=cad
                                        tp2[xa]=codigo
                                        tp3[xa]=descri
                                        skip
                                next xa
                                @ 9,9 clear to 13,41 
                                @ 9,9 to 13,41 double
                                ti=achoice(10,10,12,40,tp)
                                if lastkey()<>27
                                        select 1
                                        go top
                                        set filter to ti=tipart
                                        copy to artaux
                                endif
                endcase
                if lastkey()=27
                        select 1
                        set index to
                        inkey()
                else
                        set color to w/n*
                        set cursor off
                        @ 10,24 say "IMPRIMIENDO LISTADO, AGUARDE"
                        set color to 
                        do while .t.
                                if isprinter()=.t.
                                        set device to printer
                                        imprimec()
                                        exit
                                else
                                        set device to screen
                                        set color to gr+/b*
                                        set cursor off
                                        impx:=savescreen(16,1,16,78)
                                        @ 16,15 say "ญญ PRENDA LA IMPRESORA Y DESPUES PULSE UNA TECLA !!"
                                        inkey(0)
                                        if lastkey()=27
                                                return
                                        endif
                                        set color to 
                                        set cursor on
                                        restscreen(16,1,16,78,impx)
                                endif
                        enddo
                        set cursor on
                        set device to screen
                        @ 10,24 say "                            "
                endif
        endif
        restscreen(3,1,23,78,sxs)
enddo
erase artaux
return





function errorc()
set color to w+/gr*
set cursor off
@ 23,1 say "ญ ESE INGRESO ESTA MAL HECHO !"
inkey(0)
set color to
set cursor on
return








function imprimec()
go top
f=5
pag=0
encac()

//           10        20        30        40        50        60        70        80        90        100       110       120       130
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
// ///// ////////////////////////////////// // ////////////////// // //////////////////  /  // ////////////////// ///.// ///.// ///.//
                                        
do while .not. eof()
        @ f,0  say nroart picture "99999"
        @ f,6  say nomart picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        @ f,41 say fabart picture "99"
        aux=fabart
        select 2  //// BUSCA NOMBRE DEL FABRICANTE
        seek aux
        @ f,44 say descri picture "!!!!!!!!!!!!!!!!!!"
        select 1                   
        @ f,63 say rubart picture "99"
        aux=rubart
        select 3  //// BUSCA NOMBRE DEL RUBRO
        seek aux
        @ f,66 say descri picture "!!!!!!!!!!!!!!!!!!"
        select 1                   
        @ f,86 say estart picture "!"
        @ f,89 say tipart picture "99"
        aux=tipart
        select 4  //// BUSCA NOMBRE DEL TIPO DE JUEGO
        seek aux
        @ f,92 say descri picture "!!!!!!!!!!!!!!!!!!"
        select 1                   
        @ f,111 say p_cart picture "999.99"
        @ f,118 say p_aart picture "999.99"
        @ f,125 say p_vart picture "999.99"
        f=f+1
        skip
        if f=65
                f=5
                eject
                encac()
        endif
enddo
eject
return







function encac()
          //           10        20        30        40        50        60        70        80        90        100       110       120       130
          // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          // ///// ////////////////////////////////// // ////////////////// // //////////////////  /  // ////////////////// ///.// ///.// ///.//
if orden=1 .or. orden=2
        @ 1,0   say ""
        @ 1,0   say titulo_gral
        pag=pag+1
        @ 1,122 say "Hoja:"
        @ 1,127 say pag picture "999"
        @ 2,0   say "Listado general de Cartuchos"
elseif orden=3
        @ 1,0   say ""
        @ 1,0   say titulo_gral
        pag=pag+1
        @ 1,122 say "Hoja:"
        @ 1,127 say pag picture "999"
        @ 2,0   say "Listado de Cartuchos x Fabricante"
elseif orden=4
        @ 1,0   say ""
        @ 1,0   say titulo_gral
        pag=pag+1
        @ 1,122 say "Hoja:"
        @ 1,127 say pag picture "999"
        @ 2,0   say "Listado de Cartuchos x Rubro"
elseif orden=5
        @ 1,0   say ""
        @ 1,0   say titulo_gral
        pag=pag+1
        @ 1,122 say "Hoja:"
        @ 1,127 say pag picture "999"
        @ 2,0   say "Listado de Cartuchos x Tipo de Juego"
endif
@ 3,0   say "Cod.  Nombre                              Fabricante            Rubro                Es. Tipo de Juego         P.comp.P.alqu.P.ven."
@ 4,0   say "-----------------------------------------------------------------------------------------------------------------------------------"
return
