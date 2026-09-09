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
mensa="<< Abriendo Maestro de Socios y respectivos ¡ndices >>"
col=40-(int(len(mensa))/2)
set color to n/w*
@ 16,col say mensa
//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use maesoc
        set index to maesoc_c,maesoc_n
select 2
	use t_loca
	set index to x_loca
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
t="´ Listado de Socios Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
do while .t.
        set filter to
        @ 9,19 to 12,30 double
        @ 10,20 prompt " x CODIGO "
        @ 11,20 prompt " x NOMBRE "
        menu to orden
        sxs:=savescreen(3,1,23,78)
        if lastkey()=27
                return
        endif           
        do case
                case orden=1
                        set index to maesoc_c
                case orden=2
                        set index to maesoc_n
        endcase
        @ 9,2 clear to 12,70
        if orden=1
                go top
                d_cod=nrosoc
                go bottom
                h_cod=nrosoc
                go top
                @ 3,5 say "Desde codigo:" get d_cod picture "99999"
                @ 4,5 say "Hasta codigo:" get h_cod picture "99999"
                read
                if lastkey()=27
                        inkey()
                else
                        if d_cod<1 .or. h_cod>99999
                                error()
                        else
                                go top
                                set filter to nrosoc>=d_cod .and. nrosoc<=h_cod
                                copy to socaux
                                set color to w+/n*
                                set cursor off
                                @ 10,24 say "IMPRIMIENDO LISTADO, AGUARDE"
                                set color to 
                                set device to printer
                                imprime()
                                set cursor on
                                set device to screen
                                @ 10,24 say "                            "
                                erase SOCAUX.DBF
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
                                error()
                        else
                                go top
                                if d_cod="A" .and. h_cod="Z"
                                        inkey()
                                else
                                        set filter to (d_cod=left(nomsoc,1) .or. d_cod<left(nomsoc,1)) .and. (h_cod=left(nomsoc,1) .or. h_cod>left(nomsoc,1))
                                        copy to socaux
                                endif
                                set color to w/n*
                                set cursor off
                                @ 10,24 say "IMPRIMIENDO LISTADO, AGUARDE"
                                set color to 
                                set device to printer
                                imprime()
                                set cursor on
                                set device to screen
                                @ 10,24 say "                            "
                         endif
                endif
        endif
        restscreen(3,1,23,78,sxs)
enddo
return





function error()
set color to w+/gr*
set cursor off
@ 23,1 say "­ ESE INGRESO ESTA MAL HECHO !"
inkey(0)
set color to
set cursor on
return








function imprime()
go top
f=4
pag=0
enca()

//           10        20        30        40        50        60        70        80        90        100       110       120       130
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
// ///// ///////////////////////// /////////////////// //////////// // ///////////////// //// ////////////////////////////////////////
      
do while .not. eof()
        @ f,0  say nrosoc picture "99999"
        @ f,6  say nomsoc picture "!!!!!!!!!!!!!!!!!!!!!!!!!"
        @ f,32 say dirsoc picture "!!!!!!!!!!!!!!!!!!!"
        @ f,52 say telsoc picture "!!!!!!!!!!!!"
        @ f,65 say locsoc picture "99"
        aux=locsoc
        select 2
        seek aux
        @ f,68 say descri picture "!!!!!!!!!!!!!!!!!"
        select 1
        @ f,86 say c_psoc picture "9999"
        @ f,91 say obssoc picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        f=f+1
        skip
        if f=65
                f=4
                eject
                enca()
        endif
enddo
eject
return







function enca()
          //           10        20        30        40        50        60        70        80        90        100       110       120       130
          // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          // ///// ///////////////////////// /////////////////// //////////// // ///////////////// //// ////////////////////////////////////////
@ 1,0   say "Club de Video Games                                                                                                   Pagina:     "
pag=pag+1
@ 1,127 say pag picture "999"
@ 2,0   say "Cod.  Nombre                    Direccion           Telefono     Localidad            C.P. Observaciones                           "
@ 3,0   say "-----------------------------------------------------------------------------------------------------------------------------------"
return
