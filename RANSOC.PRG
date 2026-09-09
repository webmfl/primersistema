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


///////////////////// vectores
declare ranksoc[3000]



//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use movdia
        set index to movfal_q,movsoc_a,artalq_u,movfde_v
        reindex
select 2
        use maesoc
        set index to maesoc_c,maesoc_n
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
t="´ Ranking de alquileres Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
set cursor on
set filter to
set century on
select 1  // ------------------------------> ABRE MOVDIA
set index to movfal_q
go top
d_fec=alquil
x1=alquil
go bottom
h_fec=alquil
x2=alquil
tope=1
go top
@ 4,3  say "Desde fecha:" get d_fec valid fechas(d_fec)
@ 5,3  say "Hasta fecha:" get h_fec valid fechas(h_fec)
@ 5,30 say "Tope del Ranking?:" get tope picture "999" valid top(tope)
read
if lastkey()=27
        return
endif
///////////////////// vectores
declare ranksocx[tope]
for limpia=1 to tope
        ranksocx[limpia]=NIL
next limpia
esp()
return






function esp()
espera=" * PROCESANDO Y CONFECCIONANDO EL RANKING, AGUARDE UN MOMENTO * "
cx=40-(int(len(espera))/2)
set color to w+/b*
@ 16,cx say espera
for limpia=1 to 3000
        ranksoc[limpia]=NIL
next limpia
set color to
if x1=d_fec .and. x2=h_fec
        set index to movsoc_a
        filtro=.f.
else    
        set filter to alquil>=d_fec .and. alquil<=h_fec
        filtro=.t.
        copy to artaux
        use artaux new
        index on codsoc to x
endif
ind=0
go top
do while .not. eof()
        ind=ind+1
        veces=0
        cgo=codsoc
        do while cgo=codsoc
                veces=veces+1
                skip
        enddo
        select 2
        seek cgo
        nombre=nomsoc
        ranksoc[ind]=str(veces)+" º "+str(cgo)+" º "+nombre
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
@ 8,23 say "SOCIO"
@ 8,32 say "NOMBRE"
set color to
@ 24,1 say "[Ctrl+F1=Imprime]"
arreglasoc()
for dep=1 to tope
        ranksocx[dep]=ranksoc[dep]
next dep
pag=0
do while .t.
        set key K_CTRL_F1 to lista2
        achoice(9,10,18,70,ranksocx)
        set key K_CTRL_F1 to
        if lastkey()=27
                exit
        endif
enddo
return







function arreglasoc()

////////// O R D E N A M I E N T O     P O R    S H E L L ///////////////////
// TODO ESTO ES UN QUILOMBO     Para hacer ascende el orden debe cambiar en esta
// ESTA RUTINA SALIO DE PEDO    linea el signo "<=" por ">=" y viceversa     º
// NADIE SABE COMO FUNCIONA                                                  º
// NO TIENE LOGICA                                                           º
total_elementos=ind                                                 //       º
mitad=int(total_elementos/2)                                        //       º
do while .t.                                                        //       º
        if mitad<1                                                  //       º
                exit                                                //       º
        end if                                                      //       º
        for ciclo1=mitad+1 to total_elementos                       //       º
                temp=ranksoc[ciclo1]                                //       º
                for ciclo2= ciclo1-mitad to 1 step -mitad           //       º
                        if temp<> nil .and. ranksoc[ciclo2] <> nil  //       º
                           if temp <= ranksoc[ciclo2]               // <ÍÍÍÍÍ¼
                                        exit
                                endif
                        endif
                        ranksoc[ciclo2+mitad]=ranksoc[ciclo2]
                next ciclo2
                ranksoc[ciclo2+mitad]=temp
        next ciclo1
        mitad=int(mitad/2)
enddo
return

////////////////////////////////////////////////////////////////////////////
// FIN DEL QUILOMBO





function top(x)
if x>600 .or. x<1
        tx=.f.
else
        tx=.t.
endif
return tx





function lista2()
do while .t.
        if isprinter()=.t.
                set device to printer
                ec2()
                for dep=1 to tope
                        @ f,0 say ranksocx[dep]
                        f=f+1
                        if f=55
                                ec2()
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








function ec2()
pag=pag+1
@ 0,0 say chr(18)
@ 0,0 say titulo_gral
@ 0,70 say "Hoja:"
@ 0,75 say pag picture "999"
@ 1,32 say "Ranking de Socios"
@ 2,0 say "--------------------------------------------------------------------------------"
f=3
return

