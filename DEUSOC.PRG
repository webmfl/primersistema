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
t="´ Deudas generales de dinero Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
sdeuda=0
pos=0
sp:=savescreen(16,0,16,80)
set color to gr+*/b
@ 16,27 say " Buscando Deudas de Dinero... "
go top
for limpia=1 to 3000
        vecdeu[limpia]=NIL
next limpia
do while .not. eof()
        tot1=0
        tot2=0
        tot3=0
        socio=codsoc
        do while codsoc=socio
                aux=codsoc
                select 2
                seek aux
                nombre=nomsoc
                select 1
                tot1=tot1+deualq
                tot2=tot2+recalq
                tot3=tot3+varios
                skip
        enddo
        xtot=tot1+tot2
        deuda=xtot-tot3
        sdeuda=sdeuda+deuda
        if deuda>0
                pos=pos+1
                vecdeu[pos]=str(aux)+" "+nombre+str(deuda)
        endif
enddo
restscreen(16,0,16,80,sp)
set color to
@ 8,9 to 19,71 double
set color to w+/b
@ 8,10 say "Nombre del Socio"
@ 8,62 say "Monto"
@ 19,10 say "Total de deuda="
@ 19,29 say sdeuda picture "$999999.99"
set color to
asort(vecdeu)
achoice(9,10,18,70,vecdeu)
return
