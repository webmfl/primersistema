close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino variables publicas
public pan3:={}
public campo:={}
public cadena:=""
public n:={}
public x:={}
public borro:={}
public tcla:={}
public marc:={}

//// defino variables claves
tcla=0
N=1
confirmo=.t.
marc=0
set cursor off
mensa="<< Abriendo Maestro de Art¡culos y respectivos ¡ndices >>"
col=40-(int(len(mensa))/2)
sxs:=savescreen(16,0,16,80)
set color to n/w*
@ 16,col say mensa
//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use maeart
        set index to maeart_c,maeart_n
select 2
        use t_fabr
        set index to x_fabr
select 3
        use t_rubr
        set index to x_rubr
select 4
        use t_tipo
        set index to x_tipo
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
set key K_F2 to btablaart()
do while .t.
        dibu()
        set color to
        tocarrib=.f.
        marc=0
        desp=.f.
        if confirmo=.t.
                nro_articulo=0
                nombre_articulo=space(40)
                fabricante_articulo=0
                rubro_articulo=0
                tipo_articulo=0
                precio_compra=0
                precio_alquiler=0
                precio_venta=0
                estado_articulo=space(1)
        else
                set color to w+/b
                mens="< F6=Borrar >"
                cx=73-(int(len(mens))/2)
                @ 3,cx say mens
                set color to
        endif
        t="´ B A S E   D E   A R T I C U L O S Ã"
        // if confirmo=.t.
        //         @ 9,16 say replicate(" ",20)
        // endif
        cx=40-(int(len(t))/2)
        @ 2,cx say t
        set key K_F1 to ayudaart()
        @ 24,1  say"<F1=Art¡culos>Ä<F2=Tablas>ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        set cursor on
        if confirmo=.t.
                ultimoart()
        endif
                        @ 3,2   say "N§ de Art¡culo:" get nro_articulo picture "99999" valid existeart(nro_articulo)
                        @ 5,5   say "Nombre:" get nombre_articulo picture ("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                        @ 7,2   say "Fabricante:" get fabricante_articulo picture ("99") valid buscaart(fabricante_articulo)
                        @ 7,45  say "Rubro:" get rubro_articulo picture ("99") valid buscaart(rubro_articulo)
                        @ 9,2   say "Tipo:" get tipo_articulo picture ("99") valid buscaart(tipo_articulo)
                        @ 11,2  say "Precio de compra:" get precio_compra picture "999.99" 
                        @ 11,45 say "Precio de alquiler:" get precio_alquiler picture "999.99"
                        @ 13,2  say "Precio de venta:" get precio_venta picture "999.99" 
                        @ 13,45 say "Activo:" get estado_articulo picture "!" valid(estado_articulo$"SN ")
                        eli:=savescreen(3,0,25,80)
                        read
                        set key K_F6 to
                        if lastkey()<>27
                                set color to 
                                pan:=savescreen(17,16,19,46)
                                @ 17,16 clear to 19,46
                                @ 17,16 to 19,46
                                @ 24,66 say"ÄÄÄÄÄÄÄÄÄÄÄÄ"
                                @ 18,17 say"Confirma este ingreso"
                                @ 18,41 prompt"SI"
                                @ 18,44 prompt"NO"
                                menu to opxx
                                @ 17,16 clear to 19,46
                                restscreen=(17,16,19,46,pan)
                                do case 
                                        case opxx=1
                                                if marc=0   // esta marca esta para que cuando modifica no deje un registro en blanco
                                                        append blank
                                                endif
                                                replace nroart with nro_articulo, ;
                                                        nomart with nombre_articulo, ;
                                                        fabart with fabricante_articulo, ;
                                                        rubart with rubro_articulo, ;
                                                        tipart with tipo_articulo, ;
                                                        p_cart with precio_compra, ;
                                                        p_aart with precio_alquiler, ;
                                                        p_vart with precio_venta, ;
                                                        estart with estado_articulo
                                                        commit
                                                confirmo=.t.      
                                        case opxx=2
                                                confirmo=.f.
                                end case
                        elseif lastkey()=27 .and. marc=0
                                confirmo=.t.
                                restscreen(3,0,25,80,eli)
                                exit
                        endif
                set color to
                mens="             "
                cx=73-(int(len(mens))/2)
                @ 3,cx say mens
        enddo
return









function existeart(aux1)
// if lastkey()=5
//         if nro_articulo=0
//                 return .f.
//         endif
//         tocarrib=.t.
//         aux1=aux1-1
//         do while .t.
//                 seek aux1
//                 if found()
//                         exit
//                 else
//                         go top
//                         if nroart-1=aux1
//                                 xp=savescreen (0,0,24,80)
//                                 set color to w+/n*
//                                 set cursor off
//                                 men=" << Este es el primero >> "
//                                 col=40-(int(len(men))/2)
//                                 @ 23,col say men
//                                 inkey(3)
//                                 set cursor on
//                                 set color to
//                                 restscreen (0,0,24,80,xp)
//                                 exit
//                         else
//                                 aux1=aux1-1
//                         endif
//                 endif
//         enddo
// elseif lastkey()=24 .and. tocarrib=.t. 
//         aux1=aux1+1
//         do while .t.
//                 seek aux1
//                 if found()
//                         exit
//                 else
//                         go bottom
//                         if nroart+1=aux1
//                                 xp=savescreen (0,0,24,80)
//                                 set color to w+/n*
//                                 set cursor off
//                                 men=" << Este es el £ltimo >> "
//                                 col=40-(int(len(men))/2)
//                                 @ 23,col say men
//                                 inkey(3)
//                                 set cursor on
//                                 set color to
//                                 restscreen (0,0,24,80,xp)
//                                 exit
//                         else
//                                 aux1=aux1+1
//                         endif
//                 endif
//         enddo
// endif
seek aux1
borro=.t.
if found()
        marc=1    // marca para saber si es una modificacion o no
        xx:=savescreen(23,0,23,80)
        despliegaart()
        x=nroart
        set cursor off
        set color to w+/b
        mens="< F6=Borrar >"
        cx=73-(int(len(mens))/2)
        @ 3,cx say mens
        set key K_F6 to borraart()
        set cursor on
	set color to
        restscreen(23,0,23,80,xx)
        nro_articulo=nroart
        nombre_articulo=nomart
        fabricante_articulo=fabart
        rubro_articulo=rubart
        tipo_articulo=tipart
        precio_compra=p_cart
        precio_alquiler=p_aart
        precio_venta=p_vart
        estado_articulo=estart
else
        mens="             "
        cx=73-(int(len(mens))/2)
        @ 3,cx say mens
        despliegaart()
       //  nombre_articulo=space(40)
       //  fabricante_articulo=0
       //  rubro_articulo=0
       //  precio_compra=0
       //  precio_alquiler=0
       //  precio_venta=0
endif
set key K_F1 to 
@ 24,1  say"Ä<F2=Tablas>ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
esta=.t.
return esta






function despliegaart()
set color to i
@ 3,18  say nroart
@ 5,13  say nomart
@ 7,14  say fabart
@ 7,52  say rubart
@ 9,8   say tipart
fab=fabart
rub=rubart
tip=tipart
select 2
seek fab
@ 7,17 say descri picture ("!!!!!!!!!!!!!!!!!!!!")
select 3
seek rub
@ 7,55 say descri picture ("!!!!!!!!!!!!!!!!!!!!")
select 4
seek tip
@ 9,11 say descri picture ("!!!!!!!!!!!!!!!!!!!!")
select 1
desp=.t.
@ 11,20 say p_cart
@ 11,65 say p_aart
@ 13,19 say p_vart
@ 13,53 say estart
set color to
return






function ayudaart()
select 1
cadena=""
set key K_F1 to vacia2art
set key K_F8 to vacia2art
vv=readvar()
if vv<>"NRO_ARTICULO"
	RETURN .T.
END IF
go top
ac:={"NROART","NOMART"}
AC2:={"N§ ARTICULO","DESCRIPCION"}
ppa=savescreen(0,0,24,80)
set cursor off
set color to w*/n
@ 20,13 SAY REPLICATE(" ",36)
@ 20,13 say "_"
set color to
set index to maeart_n  // abre indice de nombres
reindex
set cursor on
set color to n+/bg+
@ 22,9 say " Consulta de Art¡culos  - Ctrl+PgUp=Principo - Ctrl+PgDw=Final "
@ 8,9 to 19,71
@ 19,9 to 21,71
@ 19,9 say "Ã"
@ 19,71 say "´"
dbedit(9,10,18,70,ac,"FUNRAT",,AC2)  // consulta por nombres
set color to
IF tcla=1 // si toco enter
	restscreen(0,0,24,80,ppa)
        AUXI=nroart
        set index to maeart_c
        seek auxi
        nro_articulo=auxi  // nroart
	KEYBOARD CHR(13)
else      
	set index to 
        keyboard chr(K_F8) // ultimoart()
END IF
restscreen(0,0,24,80,ppa)
set key K_F1 to ayudaart()
set key K_F8 to ultimoart
set index to maeart_c
RETURN




FUNCTION FUNRAT(NMODO)
	LOCAL NTECLA:=LASTKEY()
	LOCAL NVALRET:=DE_CONT   // para que devuelva que continua
	DO CASE
		CASE NMODO==DE_HITTOP  // si va al top
                        TONE (100,1)
		CASE NMODO==DE_HITBOTTOM  // si va al bottom
                        TONE (100,1)
		CASE NMODO==DE_EXCEPT  // si toca una tecla
                        NVALRET:=FUN2ART(NTECLA)  // va a la funcion FUN2ART
		CASE NTECLA=5 .OR. NTECLA=24  // si es flecha abajo o arriba
                        CADENA=""  // borra concatenacion de cadena
			set color to w*/n
			@ 20,13 SAY REPLICATE(" ",36)
			@ 20,13 say "_"
			set color to
	END CASE

RETURN NVALRET  //retorna si continua o no

FUNCTION FUN2ART(NTECLA)
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
		CASE NTECLA=165 .OR. NTECLA=164  // ¤ o ¥
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





function ultimoart()
	go bottom
        nro_articulo=nroart+1  // suma uno mas al ultimoart numero de campo en la base
	go top
return





function vacia2art()
return







function borraart()
set key K_F6 to vacia2art
                  //////////// SI ELIMINA  
@ 22,1 say replicate ("Ä",78)
set color to w+/n*
@ 23,2 say"Confirma ELIMINAR DEFINITIVAMENTE este art¡culo ?  "
set color to
@ 23,52 say"º"
@ 23,66 prompt" CANCELAR "
@ 23,54 prompt" ACEPTAR "           
menu to opxx3
if lastkey()=27    // si toca esc
        mens="             "
        cx=73-(int(len(mens))/2)
        @ 3,cx say mens
        @ 22,1 clear to 23,78
        return
endif
do case
        case opxx3=2
                seek x
                delete
                pack
                // ultimoart()
                keyboard chr(27)
                restscreen(3,0,25,80,eli)
        case opxx3=1
                mens="             "
                cx=73-(int(len(mens))/2)
                @ 3,cx say mens
                @ 24,1 say "<F1=Art¡culos>"
                // @ 2,60 say "<F8=Pr¢ximo c¢digo>"
                nro_articulo=0
endcase
@ 21,1 clear to 23,78
set index to maeart_c
reindex
set index to maeart_n
reindex
set index to maeart_c
dibu()
return











function buscaart(m)
do case
         case readvar()="FABRICANTE_ARTICULO"
                select 2
                seek m
                if found()
                        set color to i
                        @ 7,17 say descri picture ("!!!!!!!!!!!!!!!!!!!!")
                        select 1
                        return .t.
		else
			if m=0
                              select 1
                              return .t.
			else                
				xp=savescreen (0,0,24,80)
				set color to w+/n*
				set cursor off
				men=" << No ingresado en tabla >> "
				col=40-(int(len(men))/2)
				@ 23,col say men
				inkey(3)
				set cursor on
				set color to
				restscreen (0,0,24,80,xp)
                                select 1
                                return .f.
			end if                        
                endif
         case readvar()="RUBRO_ARTICULO"
                select 3
                seek m
                if found()
                        set color to i
                        @ 7,55 say descri picture ("!!!!!!!!!!!!!!!!!!!!")
                        select 1
                        return .t.
		else
			if m=0
                              select 1
                              return .t.
			else                
				xp=savescreen (0,0,24,80)
				set color to w+/n*
				set cursor off
				men=" << No ingresado en tabla >> "
				col=40-(int(len(men))/2)
				@ 23,col say men
				inkey(3)
				set cursor on
				set color to
				restscreen (0,0,24,80,xp)
                                select 1
                                return .f.
			end if                        
                endif
         case readvar()="TIPO_ARTICULO"
                select 4
                seek m
                if found()
                        set color to i
                        @ 9,11 say descri picture ("!!!!!!!!!!!!!!!!!!!!")
                        select 1
                        return .t.
		else
			if m=0
                              select 1
                              return .t.
			else                
				xp=savescreen (0,0,24,80)
				set color to w+/n*
				set cursor off
				men=" << No ingresado en tabla >> "
				col=40-(int(len(men))/2)
				@ 23,col say men
				inkey(3)
				set cursor on
				set color to
				restscreen (0,0,24,80,xp)
                                select 1
                                return .f.
			end if                        
                endif
end case
return





procedure btablaart()
set color to
tec=readvar()
do case
        case tec="FABRICANTE_ARTICULO"
                tlocart(1)
        case tec="RUBRO_ARTICULO"
                tlocart(2)
        case tec="TIPO_ARTICULO"
                tlocart(3)
	otherwise
                notablasart()
endcase
return








procedure notablasart()
return





procedure tlocart(vari)
set key K_F2 to vacia2art
do case
	case vari=1
                select 2
        case vari=2
                select 3
        case vari=3
                select 4
endcase
tapan=savescreen(0,0,24,80)
to=lastrec()
if to=0 
	xp=savescreen (0,0,24,80)
	set color to w+/n*
	set cursor off
	men=" << Falta cargar la tabla >> "
	@ 5,49 say men
	set color to
	@ 4,59 say replicate ("Í",19)
	inkey(3)
	set cursor on
	restscreen (0,0,24,80,xp)
        set key K_F2 to btablaart()
	return
endif

declare tp[to]
declare tp2[to]
declare tp3[to]
go top
for xa=1 to to
	cad=str(codigo)+" ³ "+descri
	tp[xa]=cad
	tp2[xa]=codigo
	tp3[xa]=descri
	skip
next xa
@ 9,9 clear to 13,41 
@ 9,9 to 13,41 double
k=.t.
do while k=.t.
xpos=achoice(10,10,12,40,tp)
do case
	case lastkey()=27
                restscreen (0,0,24,80,tapan)
		select 1
                set key K_F2 to btablaart()
		k=.f.
		return
	case lastkey()=13
		do case
			case vari=1
                                fab_aux=tp2[xpos]
				select 1
                                fabricante_articulo=fab_aux
                        case vari=2
                                rub_aux=tp2[xpos]
				select 1
                                rubro_articulo=rub_aux
                        case vari=3
                                tip_aux=tp2[xpos]
				select 1
                                tipo_articulo=tip_aux
                endcase
		keyboard chr(13)
		restscreen (0,0,24,80,tapan)
                // do case
                //         case vari=1
                //                 @ 11,16 say tp3[xpos] picture replicate("!",20)
                // end case
                set key K_F2 to btablaart()
		k=.f.
		return
	otherwise
		k=.t.
endcase
enddo
return








function dibu()
                        set color to i
                        @ 3,18  say "     "
                        @ 5,13  say "                                        " 
                        @ 7,14  say "  Û                    "
                        @ 7,52  say "  Û                    "
                        @ 9,8   say "  Û                    "
                        @ 11,20  say "000.00"
                        @ 11,65  say "000.00" 
                        @ 13,19 say "000.00" 
                        @ 13,53 say " "
                        set color to
                        nro_articulo=0
return









