close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas


/////////////////////////////  defino vector
declare vecdeu[3000]



//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use movdia
        set index to movfal_q,movsoc_a,artalq_u,movfde_v
        reindex
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
t="ด Ranking de deudas generales de dinero ร"
cx=40-(int(len(t))/2)
@ 2,cx say t
for limpia=1 to 3000
        vecdeu[limpia]=NIL
next limpia
sdeuda=0
pos=0
go top
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
                vecdeu[pos]=rtrim(str(deuda))+" ณ "+str(aux)+" "+nombre
        endif
enddo
ind=pos
if ind>0
        randeu()
endif
@ 8,13 to 19,67 double
set color to w+/b
@ 8,14 say "Monto"
@ 8,29 say "Nombre del Socio"
@ 19,14 say "Total de deuda="
@ 19,29 say sdeuda picture "$999999.99"
set color to
achoice(9,14,18,66,vecdeu)
return





function randeu()

////////// O R D E N A M I E N T O     P O R    S H E L L ///////////////////
// TODO ESTO ES UN QUILOMBO     Para hacer ascende el orden debe cambiar en esta
// ESTA RUTINA SALIO DE PEDO    linea el signo "<=" por ">=" y viceversa     บ
// NADIE SABE COMO FUNCIONA                                                  บ
// NO TIENE LOGICA                                                           บ
total_elementos=ind                                                 //       บ
mitad=int(total_elementos/2)                                        //       บ
do while .t.                                                        //       บ
        if mitad<1                                                  //       บ
                exit                                                //       บ
        end if                                                      //       บ
        for ciclo1=mitad+1 to total_elementos                       //       บ
                temp=vecdeu[ciclo1]                                //       บ
                for ciclo2= ciclo1-mitad to 1 step -mitad           //       บ
                        if temp<> nil .and. vecdeu[ciclo2] <> nil  //       บ
                           if temp <= vecdeu[ciclo2]               // <อออออผ
                                        exit
                                endif
                        endif
                        vecdeu[ciclo2+mitad]=vecdeu[ciclo2]
                next ciclo2
                vecdeu[ciclo2+mitad]=temp
        next ciclo1
        mitad=int(mitad/2)
enddo
return

////////////////////////////////////////////////////////////////////////////
// FIN DEL QUILOMBO














