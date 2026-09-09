clear
// ESTE PROGRAMA SIRVE PARA HACER FONDOS Y LOS PARAMETROS SON:
// EN LA VARIABLE COLOR VAN LAS LETRAS DE COLOR DE CA CLIPPER PARA EL FONDO
// EN LA VARIABLE RECUADRO VA UN 1 SI SE DESEA UN RECUADRO Y UN 0 SI NO SE DESEA
// EN LA VARIABLE DOBLE VA UN 1 PARA DOBLE Y UN 0 PARA SIMPLE
// EN LA VARIABLE MENU VA SI QUIERE O NO MENU PRINCIPAL 1=SI, 0=NO
#include "box.ch"
col=color
rec=recuadro
dob=doble
men=menuv
set color to w+/b+
@ 0,0 say "Club de Video Juegos                                                            "
p="Û"
for c=0 to 80
        p=p+"Û"
next c
for f=0 to 25
        set color to &col
        @ f,0 say p
        set color to 
next f
if rec=1
        if dob=1
                @ 0,0 to 24,79 double
        else
                @ 0,0 to 24,79
        endif
endif
if men=1
        set color to w+/&color
        @ 7,26 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        @ 8,26 say "³"
        @ 9,26 say "³"
        @ 10,26 say "³"
        @ 11,26 say "³"
        @ 12,26 say "³"
        @ 13,26 say "À"
        set color to n/&color 
        @ 7,52 say "¿"
        @ 8,52 say "³"
        @ 9,52 say "³"
        @ 10,52 say "³"
        @ 11,52 say "³"
        @ 12,52 say "³"
        @ 13,27 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
endif
setcolor()
