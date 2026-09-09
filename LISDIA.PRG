close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino variables publicas
public pan3:={}
public campo:={}
public cadena:=""
pagina=0
tot1=0
tot2=0
tot3=0
final=0

/////////////////// defino vector(1)

//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use movdia
        set index to movfal_q,movsoc_a,artalq_u,movfde_v
select 2
        use maesoc
        set index to maesoc_c,maesoc_n
select 3
        use maeart
        set index to maeart_c,maeart_n
select 4
        use t_tipo
        set index to x_tipo
select 5
        use t_fabr
        set index to x_fabr
select 6
        use stkmov
        set index to stkmov_a
select 7
        use gananc
        set index to gananc_f
//////////////////////////////// FIN DE LOS SELECT'S



select 1  // ------------------------------> ABRE MOVDIA

color="N"    // color blanco de fondo
recuadro=1   // sin recuadro
doble=0      // sin tipo de linea
menuv=0      // sin menu ppal
#include "fondo2.prg"
set color to w+/bg
@ 1,0 say "[Esc=Vuelve]                                                    Fecha:  /  /    "
@ 1,70 say date()
set cursor on
set color to
t="ด Listado de movimientos diarios ร"
cx=40-(int(len(t))/2)
@ 2,cx say t
do while .t.
        d_fec=date()
        h_fec=date()
        @ 5,4 say "Desde Fecha:" get d_fec 
        @ 6,4 say "Hasta Fecha:" get h_fec valid fchh(h_fec)
        read
        if lastkey()=27
                return
        endif
        imp()
enddo
return






function fchh(x)
pasa=.t.
if d_fec>h_fec
        pasa=.f.
endif
return pasa









function imp()
pagina=0
set index to movfal_q
reindex
go top
seek d_fec
if .not. found()
        go top
        if d_fec<alquil
                d_fec=alquil
        else
                set cursor off
                @ 16,30 say "No hubo movimientos en esa fecha"
                inkey(0)
                @ 16,30 say "                                "
                set cursor on
                return
        endif
endif
lini=codsoc
en()
l=3
do while h_fec>=alquil
        im=.f.
        if codsoc<>lini
                @ l,0 say "-----------------------------------------------------------------------------------------------------------------------------------"
                lini=codsoc
                l=l+1
        endif
        @ l,0 say alquil
        @ l,9 say codsoc
        aux=codsoc
        select 2
                seek aux
                @ l,15 say nomsoc
        select 1
        @ l,56 say codalq
        aux=codalq
        select 3
                seek aux
                @ l,62 say nomart
        select 1
        @ l,103 say deualq
        @ l,110 say devuel
        tot1=tot1+prealq
        tot2=tot2+deualq
        tot3=tot3+varios
        suma=tot1+tot3
        total=suma-tot2
        l=l+1
        if l=64
                @ l,0 say "-----------------------------------------------------------------------------------------------------------------------------------"
                l=l+1
                @ l,0 say "Total="
                @ l,7 say total picture "$999999.99"
                @ l+1,0 say " "
                im=.t.
                l=3
                en()
        endif
        skip
        if eof()
                exit
        endif
enddo
if im=.f.
        @ l,0 say "-----------------------------------------------------------------------------------------------------------------------------------"
        l=l+1
        @ l,0 say "Total="
        @ l,7 say total picture "$999999.99"
        @ l+1,0 say " "
        eject
endif
set device to screen
return









function en()
do while isprinter()=.f.
       set device to screen
       set color to gr+/b*
       set cursor off
       impx:=savescreen(16,1,16,78)
       @ 16,15 say "ญญ PRENDA LA IMPRESORA Y DESPUES PULSE UNA TECLA !!"
       inkey(0)
       set color to
       set cursor on
       restscreen(16,1,16,78,impx)
enddo
set device to printer
pagina=pagina+1
@ 0,0 say ""+titulo_gral
@ 0,105 say "Fecha:"
@ 0,111 say date()
@ 0,121 say "Hoja:"
@ 0,127 say pagina
        //           10        20        30        40        50        60        70        80        90        100       110       120       130
        // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
        // //////// ///// //////////////////////////////////////// ///// //////////////////////////////////////// ///.// ////////
@ 1,0 say "Alquilo  Socio Nombre                                   Art.  Descripcion                                Debe Devuelve Devolv. Pago"
@ 2,0 say "-----------------------------------------------------------------------------------------------------------------------------------"
return
