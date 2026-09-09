close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino variables publicas
public pan3:={}
public campo:={}
public cadena:=""
public n:={}
public fin:=0
public x:={}
public tcla:={}


declare ranktem[3000]
declare ranktem2[3000]



//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use movdia
        set index to movfal_q,movsoc_a,artalq_u,movfde_v
        reindex
select 2
        use maeart
        set index to maeart_c,maeart_n
select 3
        use t_tipo
        set index to x_tipo
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
t="´ Ranking de tipos de juego Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
set cursor on
set filter to
                        select 1  
set index to movfal_q
go top
d_fec=alquil
x1=alquil
go bottom
h_fec=alquil
x2=alquil
topec=1
go top
@ 4,3 say  "Desde fecha:" get d_fec valid temfechas(d_fec)
@ 5,3 say  "Hasta fecha:" get h_fec valid temfechas(h_fec)
@ 5,30 say "Tope del Ranking?:" get topec picture "999" valid top(topec)
read
if lastkey()=27
        return
endif
///////////////////// vectores
declare rankfin[topec]
for limpia=1 to topec
        rankfin[limpia]=NIL
next limpia
espct()
return






function espct()
espera=" * PROCESANDO Y CONFECCIONANDO EL RANKING, AGUARDE UN MOMENTO * "
cx=40-(int(len(espera))/2)
set color to w+/b*
@ 16,cx say espera
for limpia=1 to 3000
        ranktem[limpia]=NIL
        ranktem2[limpia]=NIL
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
        tema=tipart
        select 3
        seek tema
        nomtip=descri
        ranktem[ind]=str(tema)+" "+nomtip+str(veces)
        if filtro=.f.
                select 1
        else
                select artaux
        endif
enddo
temarregla()   // ACA ORDENA EL VECTOR POR N§ DE TEMA PARA PODER SACAR EL N§ DE VECES QUE APARECE (COMO UN INDEXADO CUALUNQUE)
v=0             
pos=0
for x=1 to 3000
        if ranktem[x]=NIL
                exit
        else
                pri=left(ranktem[x],35)
                v=0
        endif
        do while pri=left(ranktem[x],35)
                v=v+1
                x=x+1
                if ranktem[x]=NIL
                        exit
                endif
        enddo
        x=x-1
        pos=pos+1
        ranktem2[pos]=rtrim(str(v))+"  º  "+left(ranktem[x],35)
next x
ind=pos
temarr()  ///////////////// ACA ORDENA EL VECTOR QUE SE VISUALIZA FINALMENTE
for l=topec+1 to 3000   //// 
        ranktem2[l]=NIL    /// ACA DEPURA EL VECTOR SEGUN EL TOPE QUE LE PUSO EL USUARIO
next l                  ////
@ 16,1 clear to 16,78
@ 8,9,19,71 box "ÉÍ»º¼ÍÈº "
set color to w+/b
@ 8,10 say "VECES"
@ 8,23 say "TIPO DE JUEGO"
set color to
achoice(9,10,18,70,ranktem2)
return






function temfechas(x)
pasa=.t.
if x1>d_fec .or. x2<h_fec
        pasa=.f.
endif
return pasa




function temarregla()

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
                temp=ranktem[ciclo1]                                  //   º
                for ciclo2= ciclo1-mitad to 1 step -mitad              //   º
                        if temp<> nil .and. ranktem[ciclo2] <> nil    //   º
                           if temp <= ranktem[ciclo2]                 // <Í¼
                                        exit
                                endif
                        endif
                        ranktem[ciclo2+mitad]=ranktem[ciclo2]
                next ciclo2
                ranktem[ciclo2+mitad]=temp
        next ciclo1
        mitad=int(mitad/2)
enddo
return

////////////////////////////////////////////////////////////////////////////
// FIN DEL QUILOMBO








function temarr()

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
                temp=ranktem2[ciclo1]                                  //   º
                for ciclo2= ciclo1-mitad to 1 step -mitad              //   º
                        if temp<> nil .and. ranktem2[ciclo2] <> nil    //   º
                           if temp <= ranktem2[ciclo2]                 // <Í¼
                                        exit
                                endif
                        endif
                        ranktem2[ciclo2+mitad]=ranktem2[ciclo2]
                next ciclo2
                ranktem2[ciclo2+mitad]=temp
        next ciclo1
        mitad=int(mitad/2)
enddo
return

////////////////////////////////////////////////////////////////////////////
// FIN DEL QUILOMBO





