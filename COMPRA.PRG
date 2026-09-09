close databases   // cierra todas las bases abiertas
#include"dbedit.ch"  // incluye libreria control de teclas para el dbedit
#include"inkey.ch"        // incluye libreria control de teclas

/////////////////// defino variables publicas
public pan3:={}
public campo:={}
public cadena:=""
public n:={}
public x:=0
public ax:=0
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
        use stkmov
        set index to stkmov_a
select 2
        use maeart
        set index to maeart_c,maeart_n
//////////////////////////////// FIN DE LOS SELECT'S   

select 1
set index to stkmov_a
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
t="´ Movimientos de Stock Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
vu=0
do while .t.
        set color to
        @ 9,9 to 12,19 double
        @ 10,10 prompt " INGRESO "
        @ 11,10 prompt " EGRESO  "
        menu to ing
        ppal:=savescreen(0,00,25,80)
        if lastkey()=27
                return
        endif
        @ 9,9 clear to 12,19
        dibu2()
        set color to w+/n*
        if ing=1
                @ 3,58 say "Ingresando al Stock"
        else
                @ 3,58 say "Egresando del Stock"
        endif
        set color to 
        do while .t. 
                @ 21,63 to 23,77
                set color to w+/b
                @ 22,64 say "Stock:"
                @ 22,71 say "      "
                set color to
                if lastkey()=27 .and. vu=2
                        return
                endif
                artstk=0
                nomstk=space(40)
                fecstk=date()
                canstk=0
                comstk=space(40)
                set key K_F1 to articu()
                @ 3,1 say "Codigo del Articulo:" get artstk picture "99999" valid astk(artstk)
                @ 5,1 say "Nombre:                                         "
                @ 7,1 say "Fecha:" get fecstk
                @ 9,1 say "Cantidad:" get canstk picture "999999" valid nocero(canstk)
                @ 11,1 say "Comentario:" get comstk picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                read
                if lastkey()<>27
                        exit
                else 
                        vu=vu+1
                endif
        enddo   
        set key K_F1 to
        set color to
        pan:=savescreen(17,16,19,46)
        @ 17,16 clear to 19,46
        @ 17,16 to 19,46
        @ 18,17 say"Confirma este ingreso"
        @ 18,41 prompt"SI"
        @ 18,44 prompt"NO"
        menu to opxx
        @ 17,16 clear to 19,46
        restscreen(17,16,19,46,pan)
        do case 
                case opxx=1
                        append blank
                        replace stkart with artstk, ;
                                stkfec with fecstk, ;
                                stkcom with comstk
                        do case
                                case ing=1
                                        replace stking with canstk
                                case ing=2
                                        replace stkegr with canstk
                        endcase
                        commit
        endcase
        restscreen(0,00,25,80,ppal)
enddo
return







function astk(x)
seek x
ingreso=0
egreso=0
do while stkart=x
        ingreso=ingreso+stking
        egreso=egreso+stkegr
        skip
enddo
saldo=ingreso-egreso
@ 21,63 to 23,77
set color to w+/b
@ 22,64 say "Stock:"
@ 22,71 say saldo picture "999999"
set color to
select 2
set index to maeart_c
seek x
if found()
        set color to n/w
        @ 5,9 say nomart picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        set color to
        p=.t.
else
        x2:=savescreen(20,0,23,80)
        set color to b/bg*
        set cursor off
        @ 23,1 say "                    ­Ese n£mero de ARTICULO no existe!                        "
        inkey(4)
        set color to
        set cursor on
        restscreen(20,0,23,80,x2)
        p=.f.
endif
        
select 1
return p







function dibu2()
set color to n/w
@ 5,9  say "                                        "
@ 7,8  say "        "
@ 9,11 say "     "
set color to 
return









function articu()
set filter to
vv=readvar()
do case
        case vv="ARTSTK"
                select 2
        otherwise
                return .t.
endcase
cadena=""
set key K_F1 to
go top
ppa=savescreen(0,0,24,80)
ac:={"NROART","NOMART","ESTART"}
AC2:={"N§","DESCRIPCION","DISPONIBLE"}
set index to maeart_n  // abre indice de nombres
reindex
set cursor on
set color to n+/bg+
@ 22,11 say " Consulta de Art¡culos -Ctrl+PgUp=Principo-Ctrl+PgDw=Final "
set cursor off
set color to w*/n
@ 20,13 SAY REPLICATE(" ",36)
@ 20,13 say "_"
set color to n+/bg+
@ 8,9 to 19,71
@ 19,9 to 21,71
@ 19,9 say "Ã"
@ 19,71 say "´"
dbedit(9,10,18,70,ac,"constk",,AC2)  // consulta por nombres
set color to
IF tcla=1 // si toco enter
        if vv="ARTSTK"
                restscreen(0,0,24,80,ppa)
                AUXI=nroart
                set index to maeart_c
                seek auxi
                artstk=auxi
                KEYBOARD CHR(13)
        endif
else      
        select 1 
        artstk=0
        cod=0
END IF
restscreen(0,0,24,80,ppa)
set key K_F1 to articu()
set cursor on
select 1
RETURN




FUNCTION constk(NMODO)
	LOCAL NTECLA:=LASTKEY()
	LOCAL NVALRET:=DE_CONT   // para que devuelva que continua
	DO CASE
		CASE NMODO==DE_HITTOP  // si va al top
                        TONE (100,1)
		CASE NMODO==DE_HITBOTTOM  // si va al bottom
                        TONE (100,1)
		CASE NMODO==DE_EXCEPT  // si toca una tecla
                        NVALRET:=constk2(NTECLA)  // va a la funcion constk2
		CASE NTECLA=5 .OR. NTECLA=24  // si es flecha abajo o arriba
                        CADENA=""  // borra concatenacion de cadena
			set color to w*/n
			@ 20,13 SAY REPLICATE(" ",36)
			@ 20,13 say "_"
			set color to
	END CASE

RETURN NVALRET  //retorna si continua o no

FUNCTION constk2(NTECLA)
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




