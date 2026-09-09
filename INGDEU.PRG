close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino variables publicas
public pan3:={}
public campo:={}
public cadena:=""
pagina=0



//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use movdia
        set index to movfal_q,movsoc_a,artalq_u,movfde_v
select 2
        use maesoc
        set index to maesoc_c,maesoc_n
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
t="´ Ingresos por cobros de deudas Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
do while .t.
        d_fec=date()
        x1=d_fec
        h_fec=date()
        x2=h_fec
        @ 5,4 say "Desde Fecha:" get d_fec 
        @ 6,4 say "Hasta Fecha:" get h_fec valid fchh(h_fec)
        read
        if lastkey()=27
                return
        endif
        filtro()
enddo
return





function filtro()
set filter to fecvar>=d_fec .and. fecvar<=h_fec
copy to lisaux
use lisaux
ttoo=lastrec()
if ttoo=0
        set color to w+*/n
        set cursor off
        @ 16,22 say "No hubo deudas cobradas en ese per¡odo"
        inkey(3)
        @ 16,22 say "                                      "
        set cursor on
        set color to
        return
endif
select 1  // ------------------------------> CAMBIA A MOVDIA(me parece que esta linea esta el pepe pero bueno, demosla asi que asi anda jeje!)
/////////////////// defino vector(1)
declare xx[ttoo]
for z=1 to ttoo
        xx[z]=NIL
next z
go top
i=0
total=0
nocargo=.f.
for x=1 to ttoo
        if desvar=" " .and. varios=0
                skip
        else
                nocargo=.t.
                aux=codsoc
                select 2
                seek aux
                aux2=nomsoc
                select 1
                i=i+1
                xx[i]=desvar+rtrim(str(varios))+str(aux)+" "+aux2
                total=total+varios
                skip
        endif
next x
if nocargo=.f.
        set color to w+*/n
        set cursor off
        @ 16,22 say "No hubo deudas cobradas en ese per¡odo"
        inkey(3)
        @ 16,22 say "                                      "
        set cursor on
        set color to
        return
endif
ach:=savescreen(8,9,19,72)
do while .t.
        @ 8,9 to 19,71 double
        set color to w+/b
        @ 8,10 say "Descripci¢n"
        @ 8,45 say "Importe"
        @ 8,53 say "Socio"
        @ 19,10 say "Total="
        @ 19,16 say total picture "$99999.99"
        set color to
        achoice(9,10,18,70,xx)
        if lastkey()=27
                erase LISAUX.DBF
                restscreen(8,9,19,72,ach)
                return
        endif
enddo
return
