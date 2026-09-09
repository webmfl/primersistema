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
//////////////////////////////// FIN DE LOS SELECT'S



set index to maeart_c
set cursor on
color="N"    // color blanco de fondo
recuadro=1   // sin recuadro
doble=0      // sin tipo de linea
menuv=0      // sin menu ppal
#include "fondo2.prg"
set color to w+/bg
@ 1,0 say "[Esc=Vuelve]                                                    Fecha:  /  /    "
@ 1,70 say date()
set color to
t="´ Rastreo de cartuchos Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
@ 24,1 say "[F1=Art¡culos]"
do while .t.
        select 3
        elemento=0
        set key K_F1 to achoart
        @ 4,3 say "Ingrese el codigo del cartucho a rastrear:" get elemento picture "99999" valid elem(elemento)
        com:=savescreen(0,0,24,80)
        read
        set key K_F1 to
        if lastkey()=27
                return
        endif
        busqueda()
        restscreen(0,0,24,80,com)
enddo
return



function elem(x)
seek x
if found()
        @ 8,10 say "Buscando:"
        set color to w+/n*
        @ 8,20 say nomart picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        set color to
        x=.t.
else
        x2:=savescreen(20,0,23,80)
        set color to b/bg*
        set cursor off
        @ 23,1 say "                    ­Ese n£mero de ARTICULO no existe!                        "
        inkey(4)
        set color to
        set cursor on
        restscreen(20,0,23,80,x2)
        x=.f.
endif
return x






function busqueda()
select 1
set index to artalq_u
reindex
go top
seek elemento
if found()=.f.
        set color to gr+/b
        @ 16,17 say " ESTE CARTUCHO NO FIGURA PENDIENTE DE DEVOLUCION "
        set color to
        inkey(0)
        return
endif        
encontro=.f.
do while codalq=elemento
        if fdeval<>ctod("  /  /  ")
                encontro=.f.
                skip
        else
                encontro=.t.
                set color to w+/r
                @ 16,4  say alquil
                @ 16,14 say codsoc
                aux=codsoc
                select 2
                seek aux
                @ 16,20 say nomsoc
                @ 16,62 say telsoc                                                      
                @ 17,15 say dirsoc
                set color to
                @ 14,3  say "Llev¢ el:      Nombre del Socio                            Tel‚fono "
                @ 15,3  say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                @ 17,4  say "Direcci¢n:"
                @ 18,3  say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                @ 19,3  say "                            ÀÄÄÄ>> Lo alquil¢ y no figura devuelto"
                select 1
                exit
        endif
enddo
if encontro=.f.
        set color to gr+/b
        @ 16,17 say " ESTE CARTUCHO NO FIGURA PENDIENTE DE DEVOLUCION "
        set color to
        inkey(0)
        return
endif        
inkey(0)
return
