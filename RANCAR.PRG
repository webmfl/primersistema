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


declare rankcart[3000]



//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use movdia
        set index to movfal_q,movsoc_a,artalq_u,movfde_v
        reindex
select 2
        use maeart
        set index to maeart_c,maeart_n
//////////////////////////////// FIN DE LOS SELECT'S



color="N"    // color blanco de fondo
recuadro=1   // sin recuadro
doble=0      // sin tipo de linea
menuv=0      // sin menu ppal
#include "fondo2.prg"
set color to w+/bg
@ 1,0 say "[Esc=Vuelve]                                                    Fecha:  /  /    "
@ 1,70 say date()
set color to
t="´ Ranking de cartuchos Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
set cursor on
set filter to
select 1  // ------------------------------> ABRE MOVDIA
set index to movfal_q
go top
d_fec=alquil
x1=alquil
go bottom
h_fec=alquil
x2=alquil
topec=1
go top
@ 4,3 say  "Desde fecha:" get d_fec valid fechas(d_fec)
@ 5,3 say  "Hasta fecha:" get h_fec valid fechas(h_fec)
@ 5,30 say "Tope del Ranking?:" get topec picture "999" valid top(topec)
read
if lastkey()=27
        return
endif
///////////////////// vectores
declare rankcartx[topec]
for limpia=1 to topec
        rankcartx[limpia]=NIL
next limpia
espc()
return






function espc()
erase ARTAUX.DBF
espera=" * PROCESANDO Y CONFECCIONANDO EL RANKING, AGUARDE UN MOMENTO * "
cx=40-(int(len(espera))/2)
set color to w+/b*
@ 16,cx say espera
for limpia=1 to 3000
        rankcart[limpia]=NIL
next limpia
set color to
if x1=d_fec .and. x2=h_fec
        set index to artalq_u
        filtro=.f.
else    
        set filter to alquil>=d_fec .and. alquil<=h_fec
        filtro=.t.
        copy to artaux
        use artaux new
        index on codalq to x
endif
ind=0
go top
do while .not. eof()
        ind=ind+1
        veces=0
        cgo=codalq
        do while cgo=codalq
                veces=veces+1
                skip
        enddo
        select 2
        seek cgo
        nombre=nomart
        rankcart[ind]=str(veces)+" º "+str(cgo)+" º "+nombre
        if filtro=.f.
                select 1
        else
                select artaux
        endif
enddo
@ 16,1 clear to 16,78
@ 8,9,19,71 box "ÉÍ»º¼ÍÈº "
set color to w+/b
@ 8,13 say "VECES"
@ 8,23 say "ART."
@ 8,32 say "NOMBRE"
set color to
@ 24,1 say "[Ctrl+F1=Imprime]"
arregla()
for dep=1 to topec
        rankcartx[dep]=rankcart[dep]
next dep
pag=0
do while .t.
        set key K_CTRL_F1 to lista
        achoice(9,10,18,70,rankcartx)
        set key K_CTRL_F1 to
        if lastkey()=27
                exit
        endif
enddo
return






function fechas(x)
pasa=.t.
if x1>d_fec .or. x2<h_fec
        pasa=.f.
endif
return pasa




function arregla()

////////// O R D E N A M I E N T O     P O R    S H E L L ///////////////////
// TODO ESTO ES UN QUILOMBO     Para hacer ascende el orden debe cambiar en esta
// ESTA RUTINA SALIO DE PEDO   linea el signo "<=" por ">=" y viceversa     º
// NADIE SABE COMO FUNCIONA                                                 º
// NO TIENE LOGICA                                                          º
total_elementos=ind                                                    //   º
mitad=int(total_elementos/2)                                           //   º
do while .t.                                                           //   º
        if mitad<1                                                     //   º
                exit                                                   //   º
        end if                                                         //   º
        for ciclo1=mitad+1 to total_elementos                          //   º
                temp=rankcart[ciclo1]                                  //   º
                for ciclo2= ciclo1-mitad to 1 step -mitad              //   º
                        if temp<> nil .and. rankcart[ciclo2] <> nil    //   º
                           if temp <= rankcart[ciclo2]                 // <Í¼
                                        exit
                                endif
                        endif
                        rankcart[ciclo2+mitad]=rankcart[ciclo2]
                next ciclo2
                rankcart[ciclo2+mitad]=temp
        next ciclo1
        mitad=int(mitad/2)
enddo
return

////////////////////////////////////////////////////////////////////////////
// FIN DEL QUILOMBO








function lista()
do while .t.
        if isprinter()=.t.
                set device to printer
                ec()
                for dep=1 to topec
                        @ f,0 say rankcartx[dep]
                        f=f+1
                        if f=55
                                ec()
                        endif
                next dep
                set device to screen
                exit
        else
                set device to screen
                set color to gr+/b*
                set cursor off
                impx:=savescreen(16,1,16,78)
                @ 16,15 say "­­ PRENDA LA IMPRESORA Y DESPUES PULSE UNA TECLA !!"
                inkey(0)
                set color to 
                set cursor on
                restscreen(16,1,16,78,impx)
        endif
enddo
return








function ec()
pag=pag+1
@ 0,0 say chr(18)
@ 0,0 say titulo_gral
@ 0,70 say "Hoja:"
@ 0,75 say pag picture "999"
@ 1,30 say "Ranking de Cartuchos"
@ 2,0 say "--------------------------------------------------------------------------------"
f=3
return
