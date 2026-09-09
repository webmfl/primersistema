close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino vector
declare vecdeu[3000]



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
set index to movsoc_a
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
t="´ Deudas generales de cartuchos Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
pos=0
sdebe=0
sp:=savescreen(16,0,16,80)
set color to gr+*/b
@ 16,24 say " Buscando Deudas de Cartuchos... "
go top
for limpia=1 to 3000
        vecdeu[limpia]=NIL
next limpia
do while .not. eof()
        debe=0
        socio=codsoc
        do while codsoc=socio
                aux=codsoc
                select 2
                seek aux
                nombre=nomsoc
                select 1
                if fdeval=ctod("  /   /  ")
                        debe=debe+1
                endif
                skip
        enddo
        sdebe=sdebe+debe
        if debe>0
                pos=pos+1
                vecdeu[pos]=str(aux)+" "+nombre+str(debe)
        endif
enddo
restscreen(16,0,16,80,sp)
set color to
@ 8,9 to 19,71 double
set color to w+/b
@ 8,10 say "Nombre del Socio"
@ 8,62 say "Cantidad"
@ 19,10 say "Total de cartuchos="
@ 19,29 say sdebe picture "99999"
set color to
asort(vecdeu)
achoice(9,10,18,70,vecdeu)
return
