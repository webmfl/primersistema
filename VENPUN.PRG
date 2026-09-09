close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino variables publicas
public pan3:={}
public pagsoc:=0
fecha=date()
cod=0



//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use gananc
        set index to gananc_f
select 2
        use maesoc
        set index to maesoc_c

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
set cursor on
set color to
t="´ Listado de recaudaci¢n por ventas Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
do while .t.
        d_fec=date()
        x1=d_fec
        h_fec=date()
        x2=h_fec
        @ 5,4 say "Desde Fecha:" get d_fec 
        @ 6,4 say "Hasta Fecha:" get h_fec // valid fchh(h_fec)
        read
        if d_fec>h_fec
                inkey()
        else
                if lastkey()=27
                        return
                elseif lastkey()=13
                        vents()
                endif
        endif
enddo
return





function vents()
set filter to ganfec>=d_fec .and. ganfec<=h_fec
copy to lisaux
count to ttoo
// ttoo=lastrec()
if ttoo=0
        set color to w+*/n
        set cursor off
        @ 16,22 say "No hubo ventas cobradas en ese per¡odo"
        inkey(3)
        @ 16,22 say "                                      "
        set cursor on
        set color to
        return
endif
/////////////////// defino vector(1)
declare xx[ttoo]
for z=1 to ttoo
        xx[z]=NIL
next z
go top
total=0
for x=1 to ttoo
        aux=sociov
        select 2
        seek aux
        if found()
                nombre=nomsoc
                nombre=stuff(nombre,15,25," ")
        else
                aux=0
                nombre=""
        endif
        select 1
        if aux=0
                xx[x]=dtoc(ganfec)+rtrim(str(ganing))+"$"+"  -------------------  "+nombre+" "+gandes
        else
                xx[x]=dtoc(ganfec)+rtrim(str(ganing))+"$"+" "+rtrim(str(aux))+" "+nombre+" "+gandes
        endif
        ganancia=ganing-ganegr
        total=total+ganancia
        skip
next x
ach:=savescreen(8,1,19,78)
do while .t.
        @ 8,1 to 19,78 double
        set color to w+/b
        @ 8,2  say "Fecha"
        @ 8,14 say "Imp."
        @ 8,19 say "Socio"
        @ 8,41 say "Detalle"
        @ 19,10 say "Total="
        @ 19,16 say total picture "$99999.99"
        set color to
        achoice(9,2,18,77,xx)
        if lastkey()=27
                erase LISAUX.DBF
                restscreen(8,1,19,78,ach)
                return
        endif
enddo
return
