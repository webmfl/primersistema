close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino variables publicas
public pan3:={}
public campo:={}
public cadena:=""
public nombrx:=""
public xnom:=""
public n:={}
public x:={}
public borro:={}
public tcla:={}
public marc:={}
public vta:=.f.
public pend:=.f.
public rr:=0
public f:=0
public n_parche:=0
public cant:=0
public recargo:=0
public deusoc:=0
public pagsoc:=0
fecha=date()
valor=0
deudas=0
cod=0
des=space(40)
nombre=space(40)
esta_en=""
observaciones=space(35)
prevta=0
precio=0
dev=ctod("  /  /  ")
nro_socio=0
sub_total=0

/////////////////// defino vector(1)

declare alquiler[5,17]
declare vdevo[60]
declare xdevo[60]
declare pdevo[60]
declare vbase[60]
declare artde[60]
declare visdeu[30]
declare rubros[50]
declare cubros[50]        
declare fabric[50]
declare cabric[50]
// declare y2kvector[12]

//////////////// declaro vector
declare hist[1200]


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

color="N"    // color blanco de fondo
recuadro=1   // sin recuadro
doble=0      // sin tipo de linea
menuv=0      // sin menu ppal
#include "fondo2.prg"
set color to w+/bg
@ 1,0 say "[Esc=Vuelve]                                                    Fecha:  /  /    "
@ 1,70 say date()
set cursor on
set color to w+/r
set epoch to 2000
@ 2,1 say "[F5=Borra rengl¢n]"
@ 2,58 say "[F8=Cierra operaci¢n]"
set color to
t="¥ Pantalla de alquiler diario √"
cx=40-(int(len(t))/2)
@ 2,cx say t
//          12345678901234567890123456789012345678901234567890123456789012345678901234567890
set color to n+/w+
@ 3,1 say  "Fecha     C¢digo   Descripci¢n                             Precio   Devoluci¢n"
set color to
@ 4,0 say "√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥"
f=5

select 2  // ------------------------------> CAMBIA A MAESOC

// clear
do while .t.
        do while .t.
                for l1=1 to 5
                        for l2=1 to 17
                                alquiler[l1,l2]=NIL
                        next l2
                next l1
                set key K_F1 to ayu
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                esta_en="socios"
                set color to w+/n
                @ 24,1  say "F1=[Socios]"
                @ 24,13 say "F4=[Ventas]"
                set color to
                set index to maesoc_c
                @ 22,1 say"Nß Socio:" get nro_socio picture "99999"
                panini:=savescreen(0,0,25,80)
                read
                set key K_F1 to
                @ 24,1 say "ƒƒƒƒƒƒƒƒƒƒƒ"
                if lastkey()=27
                        return
                endif
                seek nro_socio
                if found()
                        if estsoc="N"
                                x:=savescreen(15,0,15,80)
                                @ 23,1  say nomsoc picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                                @ 23,31 say dirsoc picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                                @ 23,70 say telsoc picture "!!!!!!!!!"
                                set color to w*+/r
                                set cursor off
                                @ 15,10 say " ≠ ATENCION ----------> Ese n£mero de SOCIO esta inactivo "
                                inkey(5)
                                set color to
                                set cursor on
                                restscreen(15,0,15,80,x)
                        else
                                @ 23,1  say nomsoc picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                                @ 23,31 say dirsoc picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                                @ 23,70 say telsoc picture "!!!!!!!!!"
                                n_parche=nro_socio
                                exit
                        endif
                else
                        x:=savescreen(23,0,23,80)
                        set color to b/bg*
                        set cursor off
                        @ 23,1 say "                       ≠Ese n£mero de SOCIO no existe!                        "
                        inkey(4)
                        set color to
                        set cursor on
                        restscreen(23,0,23,80,x)
                endif
        enddo           

        deudores()

        devpen()

        select 2 // ------------------------------> CAMBIA A MAESOC

        do while .t.
                if lastkey()=27 .and. reng=.t.
                        sub_total=sub_total-alquiler[4,f-4]
                        @ f,1 clear to f,78
                        @ f+1,1 clear to f+1,78
                endif
                reng=.f.
                set key K_F2 to devoluciones
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                esta_en="articulos"
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F8 to cierre
                set key K_F8 to cierre
                set key K_F10 to visdeu
                set color to b/bg
                @ 22,46 say "TOTAL >>>>> $"
                @ 22,59 say sub_total picture "999.99"
                set color to
                @ f,1  say fecha
                set key K_F1 to ayu
                set key K_F3 to rubro
                @ 24,1 say "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
                set color to w+/n
                @ 24,1 say "F1=[Art°c.]"
                @ 24,23 say "F3=[Rubros]"
                @ 24,35 say "F4=[Ventas]"
                @ 24,47 say "F6=[Hist.]"
                if pend=.t.
                        set color to w+*/n
                        @ 24,13 say "F2=[Dev.]"
                else
                        set color to w+/n
                        @ 24,13 say "F2=[Dev.]"
                endif
                set color to
                @ f,12 get cod picture "99999" valid arti(cod)
                @ f,60 get precio picture "999.99"
                @ f,68 get dev
                read
                set key K_F1 to
                set key K_F2 to
                set key K_F3 to
                set key K_F4 to
                set key KP_ALT_SLASH to
                set key K_F6 to
                set key K_F8 to
                set key K_F10 to
                @ 24,1 say "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
                if lastkey()=27 .and. reng=.f.

                        select 2 // ------------------------------> CAMBIA A MAESOC

                        f=5
                        sub_total=0
                        nro_socio=0
                        restscreen(0,0,25,80,panini)
                        exit
                elseif lastkey()=13
                        alquiler[1,f-4]=fecha
                        alquiler[2,f-4]=cod
                        alquiler[3,f-4]=nombre
                        alquiler[4,f-4]=precio
                        alquiler[5,f-4]=dev
                        cod=0
                        sub_total=sub_total+precio
                        precio=0
                        dev=ctod("  /  /  ")
                        if f<18
                                f=f+1
                        endif
                endif
        enddo
enddo








function renglon()
        if f=5
                return
        endif
        reng=.t.
        @ f,1 clear to f,78
        set key K_F5 to
        alquiler[2,f-5]=NIL
        alquiler[1,f-4]=NIL
        alquiler[2,f-4]=NIL
        alquiler[3,f-4]=NIL
        alquiler[4,f-4]=NIL
        alquiler[5,f-4]=NIL
        f=f-1
        keyboard chr(27)
        set key K_F5 to renglon
return









function arti(c)


select 3 // ------------------------------> CAMBIA A MAEART

set index to maeart_c
seek c
if found()
        if vta=.t.
                @ 11,16 say nomart picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                @ 13,33 say p_vart picture "$999.99"
                ing=0
                egr=0
                prevta=p_vart
                xnom=nomart
                select 6
                set index to stkmov_a
                seek c
                do while stkart=c
                        ing=ing+stking
                        egr=egr+stkegr
                        skip
                enddo
                stk=ing-egr
                if stk<5
                        if stk<0
                                set color to w+*/r
                        else
                                set color to w+*/b
                        endif
                        @ 9,49 say "Stock Disp.="
                        @ 9,61 say stk picture "9999"
                else
                        set color to w+/b
                        @ 9,49 say "Stock Disp.="
                        @ 9,61 say stk picture "9999"
                endif
                set color to
                x=.t.
        else
                if estart="S"
                        @ f,20 say nomart picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                        nombre=nomart
                        precio=p_aart
                        dev=fecha+1
                        x=.t.
                else
                        x2:=savescreen(23,0,23,80)
                        set color to gr+/b*
                        set cursor off
                        @ 23,1 say "                    ESE ARTICULO ESTA ALQUILADO O INACTIVO !                  "
                        inkey(4)
                        set color to
                        set cursor on
                        restscreen(23,0,23,80,x2)
                        x=.f.
                endif        
        endif
else
        x2:=savescreen(20,0,23,80)
        set color to b/bg*
        set cursor off
        @ 23,1 say "                    ≠Ese n£mero de ARTICULO no existe!                        "
        inkey(4)
        set color to
        set cursor on
        restscreen(20,0,23,80,x2)
        x=.f.
endif

select 1 // ------------------------------> CAMBIA A MOVDIA

rree=f-4       //////////// valida que no se repitan los codigos de cartuchos
for rep=1 to rree+1    //// (cuando alquila sin cerrar operacion)
        if alquiler[2,rep]=c
                set color to w+*/b
                @ f,20 say nombre picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                set color to
                x=.f.
        endif
next rep

return x







function nosafa(x)
if x>sub_total
        return .f.
else
        return .t.
endif
return







function cierre()        ///      F8
local getlist:={}
set color to
                set key K_F1 to
                set key K_F2 to
                set key K_F3 to
                set key K_F4 to
                set key KP_ALT_SLASH to
                set key K_F5 to
                set key K_F6 to
                set key K_F8 to
                set key K_F10 to
items=f-5
if deusoc=0 .and. items=0
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                return
endif
cie:=savescreen(9,15,19,65)
@ 9,15,18,65 box "…Õª∫ºÕ»∫±"
@ 13,16 to 13,64
@ 16,16 to 16,64
abono=sub_total
@ 9,16 say " * ALQUILERES *"
@ 10,16 say "Total de operaci¢n:"
@ 10,35 say sub_total picture "$ 999.99"
@ 11,16 say "Importe que se abona?:" get abono picture "$ 999.99" valid nosafa(abono)
read
if lastkey()=27
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                restscreen(9,15,19,65,cie)
                return
endif
        
deudas=sub_total-abono
if deudas>0
        set color to w+/rb+
        set cursor off
        av:=savescreen(7,20,9,60)
        @ 7,20 say " A este socio se le registr¢ $    .   "
        @ 8,20 say "       en concepto de deuda !!!!      "
        @ 9,20 say "     Pulse Enter para continuar       "
        @ 7,49 say deudas picture "$ 999.99"
        do while .t.
                inkey(0)
                if lastkey()=13
                        exit
                endif
        enddo
        set color to
        set cursor on
        restscreen(7,20,9,60,av)
endif
@ 13,16 say " * CANCELACION DE DEUDAS *"
valor=0
observaciones=space(35)
@ 14,16 say "Observaciones:" get observaciones picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
@ 15,16 say "Valor:" get valor picture "999.99" valid monto(valor)
read
@ 17,16 say "TOTAL >>>>>>>>>>>>>>>"
total=sub_total+valor
@ 17,40 say total picture "$ 999.99"
set color to w+*/n
@ 18,16 say "À"
@ 19,16 say "»Õ>"
set color to
impr=.f.
set key KP_ALT_SLASH to ticket
@ 19,20 say "®CIERRA OPERACION?"
@ 19,39 prompt " SI "
@ 19,45 say    "[Esc=No]"
menu to c
set key KP_ALT_SLASH to
restscreen(9,15,19,65,cie)
if items>0
do case                                  
        case c=1 .and. items>0
                if impr=.t.
                do while .t.
                        if isprinter()=.t.
                                set device to printer
                                @ fi,0   say "VIRTUAL GAME ------------ Lo mejor en video game"
                                @ fi+1,0 say "------------------------------------------------"
                                @ fi+2,0 say "Alquilo  Cod.  Nombre          Precio Devolucion"
                                if deudas>0
                                        @ fi+3,0 say "************************************************"
                                else
                                        @ fi+3,0 say "------------------------------------------------"
                                endif
                                for ticket=1 to items
                                        @ fi+3+ticket,0  say alquiler[1,ticket]
                                        @ fi+3+ticket,9  say alquiler[2,ticket]         
                                        @ fi+3+ticket,15 say alquiler[3,ticket] picture "!!!!!!!!!!!!!!!"
                                        @ fi+3+ticket,31 say alquiler[4,ticket]
                                        @ fi+3+ticket,38 say alquiler[5,ticket]
                                next ticket
                                if valor<>0                                    
                                        @ fi+4+items,0  say observaciones picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                                        @ fi+4+items,31 say valor picture "999.99"
                                        items=items+1
                                endif
                                @ fi+4+items,0  say "------------------------------------------------"
                                @ fi+5+items,0  say "  TOTAL >>>>>>>>>>>>"
                                @ fi+5+items,31 say total picture "$999.99"
                                @ fi+6+items,0  say "-------------------------------------------     "
                                if nro_socio=0
                                        nro_socio=n_parche
                                endif
                                @ fi+6+items,43 say nro_socio picture "99999"
                                @ fi+7+items,0  say " "
                                fi=prow()+3
                                exit
                        else
                                set device to screen
                                set color to gr+/b*
                                set cursor off
                                impx:=savescreen(16,1,16,78)
                                @ 16,15 say "≠≠ PRENDA LA IMPRESORA Y DESPUES PULSE UNA TECLA !!"
                                inkey(0)
                                set color to 
                                set cursor on
                                restscreen(16,1,16,78,impx)
                        endif
                enddo
                set device to screen

                select 1 // ------------------------------> CAMBIA A MOVDIA

                        if valor<>0
                                items=items-1
                        endif
                endif

                select 1 // ------------------------------> CAMBIA A MOVDIA
                for graba=1 to items
                        append blank
                        replace alquil with alquiler[1,graba], ;
                                codsoc with nro_socio , ;
                                codalq with alquiler[2,graba], ;
                                prealq with alquiler[4,graba], ;
                                devuel with alquiler[5,graba]
                        commit
                        aux1=codalq

                        select 3

                        seek aux1
                        replace estart with "N"
                        commit

                        select 1
                next graba
                if deudas<>0                                    
                        vd1=deualq
                        vd2=deudas
                        deufin=vd1+vd2
                        replace deualq with deufin
                        commit
                endif
                        if valor<>0
                                items=items-1
                                va1=varios
                                va2=valor
                                valorfinal=va1+va2
                                replace fecvar with date()
                                replace desvar with observaciones
                                replace varios with valorfinal
                                commit
                        endif
           //     wait
                reng=.f.
                keyboard chr(27)
endcase
else
        select 1 // ------------------------------> CAMBIA A MOVDIA
        skip -1
        va1=varios
        va2=valor
        valorfinal=va1+va2
        replace fecvar with date(), ;
                desvar with observaciones, ;
                varios with valorfinal
                commit
                reng=.f.
                keyboard chr(27)
endif
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                
return







function ayu()       /// F1
set filter to
set key K_F1 to
set key K_F2 to
set key K_F3 to
set key K_F4 to             
set key KP_ALT_SLASH to
set key K_F5 to             
set key K_F6 to
set key K_F8 to
set key K_F10 to
vv=readvar()
// ? vv
// wait
// if vv<>"NRO_SOCIO" .or. vv<>"COD"
//         ? "se metio mal"
//         wait
//         RETURN .T.
// END IF

do case
        case vv="NRO_SOCIO"
                select 2 // ------------------------------> CAMBIA A MAESOC
        case vv="COD" .or. vv="NART"
                select 3 // ------------------------------> CAMBIA A MAEART
        otherwise
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                return .t.
endcase

cadena=""
go top
ppa=savescreen(0,0,24,80)
if vv="NRO_SOCIO"
        ac:={"NROSOC","NOMSOC"}
        AC2:={"Nß SOCIO","APELLIDO Y NOMBRE"}
        set index to maesoc_n  // abre indice de nombres
        reindex
        set cursor on
        set color to n+/bg+
        @ 22,11 say " Consulta de Socios - Ctrl+PgUp=Principo - Ctrl+PgDw=Final "
elseif vv="COD" .or. vv="NART"
        ac:={"NROART","NOMART","ESTART"}
        AC2:={"Nß","DESCRIPCION","DISPONIBLE"}
        set index to maeart_n  // abre indice de nombres
        reindex
        set cursor on
        set color to n+/bg+
        @ 22,11 say " Consulta de Art°culos -Ctrl+PgUp=Principo-Ctrl+PgDw=Final "
endif                                      
set cursor off
set color to w*/n
@ 20,13 SAY REPLICATE(" ",36)
@ 20,13 say "_"
set color to n+/bg+
@ 8,9 to 19,71
@ 19,9 to 21,71
@ 19,9 say "√"
@ 19,71 say "¥"
dbedit(9,10,18,70,ac,"funal",,AC2)  // consulta por nombres
set color to
IF tcla=1 // si toco enter
        if vv="NRO_SOCIO"
                restscreen(0,0,24,80,ppa)
                AUXI=nrosoc
                set index to maesoc_c
                seek auxi
                nro_socio=auxi  
                KEYBOARD CHR(13)
        elseif vv="COD" .or. vv="NART"
                restscreen(0,0,24,80,ppa)
                AUXI=nroart
                set index to maeart_c
                seek auxi
                cod=auxi
                nart=auxi
                KEYBOARD CHR(13)
        endif
else      
        if vv="NRO_SOCIO"
                select 2 // ------------------------------> CAMBIA A MAESOC

                set index to maesoc_c
                nro_socio=0
        elseif vv="COD"
                select 3 // ------------------------------> CAMBIA A MAEART

                set index to maeart_c
                cod=0                      
        elseif vv="NART"
                select 6 // ------------------------------> CAMBIA A STKMOV

                set index to stkmov_a
                nart=0                      
 
        endif


END IF
restscreen(0,0,24,80,ppa)
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
set cursor on
RETURN




FUNCTION FUNAL(NMODO)
	LOCAL NTECLA:=LASTKEY()
	LOCAL NVALRET:=DE_CONT   // para que devuelva que continua
	DO CASE
		CASE NMODO==DE_HITTOP  // si va al top
                        TONE (100,1)
		CASE NMODO==DE_HITBOTTOM  // si va al bottom
                        TONE (100,1)
		CASE NMODO==DE_EXCEPT  // si toca una tecla
                        NVALRET:=FUN2AL(NTECLA)  // va a la funcion FUN2AL
		CASE NTECLA=5 .OR. NTECLA=24  // si es flecha abajo o arriba
                        CADENA=""  // borra concatenacion de cadena
			set color to w*/n
			@ 20,13 SAY REPLICATE(" ",36)
			@ 20,13 say "_"
			set color to
	END CASE

RETURN NVALRET  //retorna si continua o no

FUNCTION FUN2AL(NTECLA)
	LOCAL NVAL:=DE_CONT // para que continue
	DO CASE
		CASE NTECLA==27  // si toca esc
			tcla=2
			NVAL:=DE_ABORT  // devuelve que no continue
		CASE (NTECLA>=65 .AND. NTECLA<=90) .OR. (NTECLA>=97 .AND. NTECLA<=122)  // si toca una letra
			CADENA=CADENA+UPPER(CHR(NTECLA))  // concatena en mayuscula
                        set color to
			@ 20,13 SAY REPLICATE(" ",36)
                        @ 20,13 SAY CADENA PICTURE REPLICATE("!",35)
			set color to w*/n
			SEEK CADENA
			IF FOUND()
				N=RECNO()
			END IF
			GO N
		CASE NTECLA=165 .OR. NTECLA=164  // § o •
			CADENA=CADENA+UPPER(CHR(NTECLA))
                        set color to
			@ 20,13 SAY REPLICATE(" ",36)
                        @ 20,13 SAY CADENA PICTURE REPLICATE("!",35)
			set color to w*/n
			SEEK CADENA
			IF FOUND()
				N=RECNO()
			END IF
			GO N
		CASE NTECLA=44 //  si toca ,
			CADENA=CADENA+CHR(NTECLA)
                        set color to
			@ 20,13 SAY REPLICATE(" ",36)
                        @ 20,13 SAY CADENA PICTURE REPLICATE("!",35)
			set color to w*/n
			SEEK CADENA
			IF FOUND()
				N=RECNO()
			END IF
			GO N
		CASE NTECLA=32 // si deja espacio
			CADENA=CADENA+CHR(NTECLA)
                        set color to
			@ 20,13 SAY REPLICATE(" ",36)
                        @ 20,13 SAY CADENA PICTURE REPLICATE("!",35)
			set color to w*/n
			SEEK CADENA
			IF FOUND()
				N=RECNO()
			END IF
			GO N
		CASE NTECLA=27 // si toca esc
			CADENA=CADENA+CHR(NTECLA)
                        set color to
			@ 20,13 SAY REPLICATE(" ",36)
                        @ 20,13 SAY CADENA PICTURE REPLICATE("!",35)
			set color to w*/n
			SEEK CADENA
			IF FOUND()
				N=RECNO()
			END IF
			GO N
		CASE NTECLA=8  // si borra desconcatena uno menos
			XCA=LEN(CADENA)
			IF XCA>0
				CADENA=SUBSTR(CADENA,1,XCA-1)
                                set color to
                                @ 20,13 SAY REPLICATE(" ",36)
                                @ 20,13 SAY CADENA PICTURE REPLICATE("!",35)
                                set color to w*/n
				SEEK CADENA
                		IF FOUND()
					N=RECNO()
				END IF
				GO N
			ELSE  
                                TONE (100,1)  // si ya borro todo y sigue borrando
			END IF
		CASE NTECLA=13 // si toco enter
			tcla=1
			N=RECNO()
			CAMPO=N
			NVAL:=DE_ABORT
	END CASE
	if len(cadena)>35
		cadena=substr(cadena,1,35)  // si se pasa del espacio no concatena mas
	else
		lle=len(cadena)
		set color to w*/n
		@ 20,13+lle say "_"
		set color to
	end if
RETURN NVAL






function deudores()

select 1 // ------------------------------> CAMBIA MOVDIA

deuaux=0
pagsoc=0
recaux=0
set index to movsoc_a
seek nro_socio
if found()
        do while .t.
                deuaux=deuaux+deualq
                pagsoc=pagsoc+varios
                recaux=recaux+recalq
                skip
                if codsoc<>nro_socio
                        exit
                endif
        enddo
        deu=deuaux+recaux
        deusoc=deu-pagsoc
        if deusoc>0
                set color to w+/r*
                @ 24,58 say " F10=DEUDA: $ 999.99 "
                @ 24,70 say deusoc picture "$ 999.99"
                set color to 
        endif
endif






function devoluciones()
local getlist:={}
                set key K_F1 to
                set key K_F2 to
                set key K_F3 to
                set key K_F4 to
                set key KP_ALT_SLASH to
                set key K_F5 to
                set key K_F6 to
                set key K_F8 to
                set key K_F10 to
devol:=savescreen(0,0,25,80)
// for ciclo_meses=1 to 12
//         y2kvector[ciclo_meses]=70*(12-ciclo_meses)
// next ciclo_meses
set color to w+/b-
@ 5,4,20,75 box "…Õª∫ºÕ»∫ "
set color to b/bg
@ 20,5 say "Recargo= $"
set color to w+/b
@ 5,26 say"π  D E V O L U C I O N E S  Ã"
@ 20,52 say"[ESC=CIERRA DEVOLUCION]"
set color to w/rb
@ 6,5  say" Alquilo   Cod.  Descripcion                                 Devuelve "
set color to

select 1  // ------------------------------> CAMBIA A MOVDIA

for limpia=1 to 60    // LIMPIO LOS CUATRO VECTORES DE BASURA
        artde[limpia]=NIL
        vdevo[limpia]=NIL
        pdevo[limpia]=NIL
        vbase[limpia]=NIL
next limpia
set index to movsoc_a
seek nro_socio
hay=.f.
c=0
if found()
        do while codsoc=nro_socio
                if fdeval=ctod("  /  /  ")
                        hay=.t.
                        c=c+1
                        coa=codalq
                        paux=prealq

                        select 3  // ------------------> CAMBIA A MAEART

                        seek coa
                        naux=nomart

                        select 1  // ------------------> CAMBIA A MOVDIA

                        vdevo[c]=" "+dtoc(alquil)+"  "+str(codalq)+" "+naux
                        xdevo[c]="no"
                        pdevo[c]=paux
                        vbase[c]=recno()
                        artde[c]=coa
                endif
                skip
        enddo
        if hay=.f.
                set color to i
                set cursor off
                @ 12,24 say " NO HAY DEVOLUCIONES PENDIENTES "
                inkey(0)
                set cursor on
                set color to 
                restscreen(0,0,25,80,devol)
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F8 to cierre
                set key K_F10 to visdeu
                return
        endif
        recargo=0
        p=1
        do while .t.
                d:=achoice(7,5,19,74,vdevo,,,p)
                if lastkey()=13
                        if xdevo[d]="no" 
                                dc=1
                                set color to n/bg
                                cd:=savescreen(14,25,17,70)
                                @ 14,27,16,56 box "…Õª∫ºÕ»∫ "
                                @ 15,29 prompt " DEVUELVE "
                                @ 15,47 prompt " CAMBIO "
                                menu to dc
                                if lastkey()=27
                                        restscreen(14,25,17,70,cd)
                                        set color to
                                        dc=3
                                endif
                                if dc=1
                                        restscreen(14,25,17,70,cd)
                                        vdevo[d]=vdevo[d]+" "+dtoc(date())
                                        xdevo[d]="si"
                                        coax=artde[d]
                                        go vbase[d]
                                        replace fdeval with date()
                                        commit
                                        dia_real=val(left(dtoc(fdeval),2))
                                        mes_real=val(substr(dtoc(fdeval),4,2))
                                        ano_real=val(str(year(fdeval)))
                                        // fecha_real=val(ano_real+mes_real+dia_real)
                                        if year(devuel)=1900 // si la fech.teor. tiene el a§o 1900
                                        //         y2k="si"
                                                dia_teorico=val(left(dtoc(devuel),2))
                                                mes_teorico=val(substr(dtoc(devuel),4,2))
                                                ano_teorico=2000
                                        //         fecha_teorica=val(ano_teorico+mes_teorico+dia_teorico)
                                        else          // si la fech.teor. es antes del 31/12/1999 inclusive o el a§o 2000 esta correctamente puesto en la fecha
                                        //         y2k="no"
                                                dia_teorico=val(left(dtoc(devuel),2))
                                                mes_teorico=val(substr(dtoc(devuel),4,2))
                                                ano_teorico=val(str(year(devuel)))
                                        //         fecha_teorica=val(ano_teorico+mes_teorico+dia_teorico)
                                        end if
                                        // if val(ano_teorico)<2000 // ''' y2k="si"
                                        //         dias=(fecha_real-fecha_teorica)-(8869+y2kvector[val(mes_teorico)])                                                // endif
                                        // else
                                        //         dias=fecha_real-fecha_teorica
                                        // endif
                                        // y2k=NIL
                                        if ano_real=ano_teorico
                                                dias=((dia_real-dia_teorico)+(mes_real-mes_teorico))
                                        elseif ano_real>ano_teorico
                                                dias=((dia_real-dia_teorico)+(12+(mes_real-mes_teorico)))
                                        endif
                                        // set color to g+/bg
                                        // @ 18,5 say dias
                                        // set color to 
                                        // wait''
                                        dias=fdeval-devuel
                                        if dias<0
                                                dias=0
                                        endif
                                        rec=dias*pdevo[d]
                                        recargo=recargo+rec
                                        set color to b/bg
                                        @ 20,5  say "Recargo= $"
                                        @ 20,15 say recargo picture "999.99"
                                        set color to

                                        select 3
                                
                                        seek coax
                                        replace estart with "S"
                                        commit

                                        select 1
                                        p=d
                                elseif dc=2
                                        codcam=0
                                        @ 17,25 say "Codigo de cambio?" get codcam picture "99999" valid codc(codcam)
                                        read
                                        if lastkey()<>27
                                                restscreen(14,25,17,70,cd)
                                                xdevo[d]="si"
                                                coax=artde[d]
                                                coax2=codcam
                                                go vbase[d]
                                                replace codalq with codcam
                                                commit
                                                select 3
                
                                                seek coax
                                                replace estart with "S"
                                                commit
        
                                                seek coax2
                                                replace estart with "N"
                                                commit


                                                select 1
                                
                                                vdevo[d]=" "+dtoc(alquil)+" "+str(codcam)+" "+nombrx+" CAMBIADO"
                                        endif
                                        restscreen(14,25,17,70,cd)
                                        set color to
                                endif
                        else
                                // @ 1,10 say "123456789012345678901234567890123456789012345678901234567890"
                                // @ 2,10 say vdevo[d]
                                // wait''
                                vdevo[d]=stuff(vdevo[d],58,14,"")
                                xdevo[d]="no"
                                coax=artde[d]
                                go vbase[d]
                                        dia_real=val(left(dtoc(fdeval),2))
                                        mes_real=val(substr(dtoc(fdeval),4,2))
                                        ano_real=val(str(year(fdeval)))
                                        // fecha_real=val(ano_real+mes_real+dia_real)
                                        if year(devuel)=1900 // si la fech.teor. tiene el a§o 1900
                                        //         y2k="si"
                                                dia_teorico=val(left(dtoc(devuel),2))
                                                mes_teorico=val(substr(dtoc(devuel),4,2))
                                                ano_teorico=2000
                                        //         fecha_teorica=val(ano_teorico+mes_teorico+dia_teorico)
                                        else          // si la fech.teor. es antes del 31/12/1999 inclusive o el a§o 2000 esta correctamente puesto en la fecha
                                        //         y2k="no"
                                                dia_teorico=val(left(dtoc(devuel),2))
                                                mes_teorico=val(substr(dtoc(devuel),4,2))
                                                ano_teorico=val(str(year(devuel)))
                                        //         fecha_teorica=val(ano_teorico+mes_teorico+dia_teorico)
                                        end if
                                        // if val(ano_teorico)<2000 // ''' y2k="si"
                                        //         dias=(fecha_real-fecha_teorica)-(8869+y2kvector[val(mes_teorico)])                                                // endif
                                        // else
                                        //         dias=fecha_real-fecha_teorica
                                        // endif
                                        // y2k=NIL
                                        if ano_real=ano_teorico
                                                dias=((dia_real-dia_teorico)+(mes_real-mes_teorico))
                                        elseif ano_real>ano_teorico
                                                dias=((dia_real-dia_teorico)+(12+(mes_real-mes_teorico)))
                                        endif
                                        // set color to g+/bg
                                        // @ 18,5 say dias
                                        // set color to 
                                        // wait''
                                dias=fdeval-devuel
                                if dias<0
                                        dias=0
                                endif
                                rec=dias*pdevo[d]
                                replace fdeval with ctod("  /  /    ")
                                commit
                                recargo=recargo-rec
                                set color to b/bg
                                @ 20,5  say "Recargo= $"
                                @ 20,15 say recargo picture "999.99"
                                set color to
                                select 3

                                seek coax
                                replace estart with "N"
                                commit

                                select 1
                                p=d
                        endif
                elseif lastkey()=27
                        if recargo>0
                                vr1=recalq
                                vr2=recargo
                                recfin=vr1+vr2
                                replace recalq with recfin
                                commit
                        endif
                        exit
                endif
        enddo
        restscreen(0,0,25,80,devol)
        if recargo>0
                deudores()
        endif
else
        set color to i
        set cursor off
        @ 12,24 say " NO HAY DEVOLUCIONES PENDIENTES "
        inkey(0)
        set cursor on
        set color to 
        restscreen(0,0,25,80,devol)
endif
devpen()
if pend=.t.
        set color to w+*/n
        @ 24,13 say "F2=[Dev.]"
        set color to
else
        set color to w+/n
        @ 24,13 say "F2=[Dev.]"
endif
set color to
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F8 to cierre
                set key K_F10 to visdeu
return


function codc(c)


select 3 // ------------------------------> CAMBIA A MAEART

set index to maeart_c
seek c
if found()
                if estart="S"
                        @ 17,49 say nomart picture "!!!!!!!!!!!!!!!!!!"
                        nombrx=nomart
                        x=.t.
                else
                        x2:=savescreen(23,0,23,80)
                        set color to gr+/b*
                        set cursor off
                        @ 23,1 say "                    ESE ARTICULO ESTA ALQUILADO O INACTIVO !                  "
                        inkey(4)
                        set color to
                        set cursor on
                        restscreen(23,0,23,80,x2)
                        x=.f.
                endif        
else
        x2:=savescreen(20,0,23,80)
        set color to b/bg*
        set cursor off
        @ 23,1 say "                    ≠Ese n£mero de ARTICULO no existe!                        "
        inkey(4)
        set color to
        set cursor on
        restscreen(20,0,23,80,x2)
        x=.f.
endif

select 1 // ------------------------------> CAMBIA A MOVDIA

return x





function devpen()
pend=.f.

select 1  // ------------------------------> CAMBIA A MOVDIA

set index to movsoc_a
seek nro_socio
if found()
        do while .t.
                if fdeval=ctod("  /  /  ")
                        pend=.t.
                        exit
                else
                        skip
                endif
                if codsoc<>nro_socio
                        exit
                endif
        enddo
endif
return






function monto()
if valor>deusoc
        llave=.f.
else
        llave=.t.
endif
return llave





function visdeu()
                set key K_F1 to
                set key K_F2 to
                set key K_F3 to
                set key K_F4 to
                set key KP_ALT_SLASH to
                set key K_F5 to
                set key K_F6 to
                set key K_F8 to
                set key K_F10 to
select 1
set index to movsoc_a
seek nro_socio
for limpia=1 to 30    // LIMPIO LOS DOS VECTORES DE BASURA
        visdeu[limpia]=NIL
next limpia
diax=date()-30
vis=.f.
cx=0
vacio=.f.
do while .t.
        if alquil>=diax
                vis=.t.
                if deualq<>0
                        vacio=.t.
                        cx=cx+1
                        fech=dtoc(alquil)
                        desc=" DEUDA ALQUILER      "
                        impo=deualq
                        visdeu[cx]=fech+"∫"+desc+"∫"+str(impo)+"∫      ∫"
                endif
                if recalq<>0
                        vacio=.t.
                        cx=cx+1
                        fech=dtoc(alquil)
                        desc=" REACARGO POR DEMORA "
                        impo=recalq
                        visdeu[cx]=fech+"∫"+desc+"∫"+str(impo)+"∫      ∫"
                endif
                if varios<>0
                        vacio=.t.
                        cx=cx+1
                        fech=dtoc(fecvar)
                        desc=" PAGO DE DEUDA       "
                        impo=varios
                        visdeu[cx]=fech+"∫"+desc+"∫      ∫"+str(impo)+"∫"
                endif
        endif
        skip
        if codsoc<>nro_socio
                exit
        endif
enddo
        x:=savescreen(5,4,20,75)
        set color to w+/b-
        @ 5,4,20,75 box "…Õª∫ºÕ»∫ "
        if vis=.t.
                if vacio=.t.
                        do while .t.
                                z:=achoice(6,5,19,74,visdeu)
                                if lastkey()=27
                                        exit
                                endif
                        enddo
                endif
        else
                set color to i
                set cursor off
                @ 12,24 say " LAS DEUDAS TIENEN MAS DE UN MES "
                inkey(0)
                set cursor on
        endif
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
        set color to
        restscreen(5,4,20,75,x)
return







function rubro()
local getlist:={}
set color to
                set key K_F1 to
                set key K_F2 to
                set key K_F3 to
                set key K_F4 to
                set key KP_ALT_SLASH to
                set key K_F5 to
                set key K_F6 to
                set key K_F8 to
                set key K_F10 to
for r=1 to 50
        rubros[r]=NIL
        cubros[r]=NIL
        fabric[r]=NIL
        cabric[r]=NIL
next r
r=0
fb=0
rr=1
ff=1
select 4
go top
do while .not. eof()
        r=r+1
        rubros[r]=str(codigo)+" "+descri
        cubros[r]=codigo
        skip
enddo
select 5
go top
do while .not. eof()
        fb=fb+1
        fabric[fb]=str(codigo)+" "+descri
        cabric[fb]=codigo
        skip
enddo
do while .t.
        rb:=savescreen(0,0,24,80)
        @ 9,9,16,31 box "…Õª∫ºÕ»∫ "
        do while .t.
        rr:=achoice(10,10,15,30,rubros)
        if lastkey()=27
                restscreen(0,0,24,80,rb)
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                return
        elseif lastkey()=13
                exit
        endif
        enddo
        do while .t.
        @ 9,44,16,66 box "…Õª∫ºÕ»∫ "
        ff:=achoice(10,45,15,65,fabric)
        if lastkey()=13
                select 3
                set filter to tipart=cubros[rr] .and. fabart=cabric[ff]
                copy to artaux
                index on nomart to x
                ac:={"NROART","NOMART","ESTART"}
                AC2:={"Nß","DESCRIPCION","DISPONIBLE"}
                @ 8,9,19,71 box "…Õª∫ºÕ»∫ "
                dbedit(9,10,18,70,ac,,,AC2)
                cod=nroart
                restscreen(0,0,24,80,rb)
                dbclearfil()
                select 2
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                return
        elseif lastkey()=27
                restscreen(0,0,24,80,rb)
                dbclearfil()
                select 2
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                return
        endif
        enddo
enddo
dbclearfil()
select 2
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
return








function venta()
local getlist:={}
                set key K_F2 to
                set key K_F3 to
                set key K_F4 to
                set key KP_ALT_SLASH to
                set key K_F5 to
                set key K_F6 to
                set key K_F8 to
                set key K_F10 to
vta=.t.
ven:=savescreen(9,15,19,65)
@ 9,15,18,65 box "…Õª∫ºÕ»∫±"
set color to w+/b
@ 9,16 say "[Ventas Puntuales]"
set color to 
do while .t.
        nart=0
        can=0
        @ 10,16 say "Nß Articulo:" get nart picture "99999" valid arti(nart)
        @ 13,16 say "Precio de Venta:"
        @ 14,16 say "Cantidad:" get can picture "999" valid nocero(can)
        ve2:=savescreen(9,15,19,65)
        set key K_F1 to ayu
        read
        set key K_F1 to
        if lastkey()=27
                restscreen(9,15,19,65,ven)
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                if esta_en="socios"
                        select 2
                elseif esta_en="articulos"
                        select 1
                endif
                vta=.f.
                return
        endif
        set color to w+/b
        impor=prevta*can
        @ 16,30 say "Importe:"
        @ 16,39 say impor picture "$9999.99"
        set color to w+/n
        set cursor off
        @ 18,16 say "[ENTER]=Cierra - [ESC]=Aborta"
        inkey(0)
        set cursor on
        set color to
        if lastkey()=13
                xsoc=nro_socio
                do while .t.
                        if isprinter()=.t.
                                set device to printer
                                  //        012345678901234567890123456789012345678901234567890123456789012345678901234567890
                                @ 0,0  say " "
                                @ 0,0  say "P R E S U P U E S T O               X           Documento no valido como factura "
                                @ 1,0  say "---------------------------------------------------------------------------------"
                                @ 2,0  say "Codigo   Nombre                               Cantidad P.Unitario   Sub total    "
                                @ 3,0  say "---------------------------------------------------------------------------------"
                                @ 4,0  say nart
                                @ 4,9  say xnom picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                                @ 4,47 say can
                                @ 4,56 say prevta picture "$999.99"
                                @ 4,68 say impor picture "$999.99"
                                @ 5,0  say "---------------------------------------------------------------------------------"
                                @ 6,0  say "  TOTAL >>>>>>>>>>>>"
                                @ 6,70 say impor picture "$999.99"
                                @ 7,0  say "---------------------------------------------------------------------------------"
                                @ 8,0  say date()
                                @ 8,75 say xsoc picture "99999"
                                set device to screen
                                exit
                        else
                                set device to screen
                                set color to gr+/b*
                                set cursor off
                                impx:=savescreen(16,1,16,78)
                                @ 16,15 say "≠≠ PRENDA LA IMPRESORA Y DESPUES PULSE UNA TECLA !!"
                                inkey(0)
                                set color to 
                                set cursor on
                                restscreen(16,1,16,78,impx)
                        endif
                enddo
                select 6
                append blank
                replace stkart with nart, ;
                        stkfec with date(), ;
                        stkegr with can
                detalle="VENTA ARTICULO "+str(nart)
                select 7
                append blank
                replace ganfec with date(), ;
                        sociov with xsoc, ;
                        gandes with detalle, ;
                        ganing with impor
                restscreen(9,15,19,65,ven)
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
                if esta_en="socios"
                        select 2
                elseif esta_en="articulos"
                        select 1
                endif
                exit
        endif
        restscreen(9,15,19,65,ve2)
enddo
vta=.f.
return





function nocero(x)
if x<0
        no=.f.
else
        no=.t.
endif
return no




function chasco()
ch:=savescreen(14,0,14,80)
set color to gr+/b
@ 14,28 say "[ Opci¢n No Habilitada ]"
inkey(0)
set color to
restscreen(14,0,14,80,ch)
return






function ticket()
impr=.t.
keyboard chr(13)
return










function historias()
                set key K_F1 to
                set key K_F2 to
                set key K_F3 to
                set key K_F4 to
                set key KP_ALT_SLASH to
                set key K_F5 to
                set key K_F6 to
                set key K_F8 to
                set key K_F10 to
xa:=savescreen(0,0,24,80)
sp:=savescreen(16,0,16,80)
set color to gr+*/b
@ 16,24 say "> Buscando Historia del Socio... "
select 2
seek nro_socio
nombresoc=nomsoc
for limpia=1 to 1200
        hist[limpia]=NIL
next limpia
select 1
set index to movsoc_a
reindex
seek nro_socio
if found()=.f.
        set color to gr+/b
        @ 16,24 say " ESTE SOCIO TODAVIA NO TIENE HISTORIA "
        set color to
        inkey(0)
        restscreen(0,0,24,80,xa)
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
        return
endif        
x=0
do while codsoc=nro_socio
                x=x+1
                aux=codalq
                select 3
                set index to maeart_c
                seek aux
                nombre=left(nomart,39)
                select 1
                if fdeval=ctod("  /  /  ")
                        devol="NO DEVUELTO"
                else
                        devol="DEVUELTO"
                endif
                set century on
                if year(alquil)=1900
                        cadena=left(dtoc(alquil),6)+"2000"
                else
                        cadena=dtoc(alquil)
                endif
                hist[x]=cadena+" "+str(aux)+" "+nombre+" "+devol+" "+dtoc(fdeval)
                skip
enddo
set century off
set color to
restscreen(16,0,16,80,sp)
@ 9,1 clear to 23,77 
@ 9,1 to 23,78 double
set color to w+/b
@ 10,2  say "Historia del Socio:"
@ 10,21 say nombresoc
set color to 
cartu2()
achoice(11,2,22,77,hist)
restscreen(0,0,24,80,xa)
                set key K_F1 to ayu
                set key K_F2 to devoluciones
                set key K_F3 to rubro
                set key K_F4 to chasco
                set key KP_ALT_SLASH to venta
                set key K_F5 to renglon
                set key K_F6 to historias
                set key K_F10 to visdeu
                set key K_F8 to cierre
return


function cartu2()

////////// O R D E N A M I E N T O     P O R    S H E L L ///////////////////
// TODO ESTO ES UN QUILOMBO     Para hacer ascende el orden debe cambiar en esta
// ESTA RUTINA SALIO DE PEDO   linea el signo "<=" por ">=" y viceversa     ∫
// NADIE SABE COMO FUNCIONA                                                 ∫
// NO TIENE LOGICA                                                          ∫
total_elementos=x                                                   //   ∫
mitad=int(total_elementos/2)                                           //   ∫
do while .t.                                                           //   ∫
        if mitad<1                                                     //   ∫
                exit                                                   //   ∫
        end if                                                         //   ∫
        for ciclo1=mitad+1 to total_elementos                          //   ∫
                dd=substr(hist[ciclo1],1,2)                  //   ∫
                mm=substr(hist[ciclo1],4,2)                  //   ∫
                aa=substr(hist[ciclo1],7,4)                  //   ∫
                xx=aa+mm+dd
                temp=val(xx)
                temp2=hist[ciclo1]                                  //   ∫
                for ciclo2= ciclo1-mitad to 1 step -mitad              //   ∫
                        dd3=substr(hist[ciclo2],1,2)                  //   ∫
                        mm3=substr(hist[ciclo2],4,2)                  //   ∫
                        aa3=substr(hist[ciclo2],7,4)                  //   ∫
                        xx3=aa3+mm3+dd3
                        temp3=val(xx3)
                        if temp<> nil .and. temp3 <> nil    //   ∫
                           if temp >= temp3                 // <Õº
                                exit
                           endif
                        endif
                        hist[ciclo2+mitad]=hist[ciclo2]
                next ciclo2
                hist[ciclo2+mitad]=temp2
        next ciclo1
        mitad=int(mitad/2)
enddo
return

////////////////////////////////////////////////////////////////////////////
// FIN DEL QUILOMBO








