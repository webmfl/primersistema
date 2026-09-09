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
t="´ Historia de cartuchos Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t                                                                 // ÉÍ> Se conecta con RASCAR.PRG
@ 24,1 say "[F1=Art¡culos]"
do while .t.
        elemento=0                                                                   // ºÍ> le rutina elem que valida
        cantidad_dias=0                                                                   // ºÍ> le rutina elem que valida
        @ 4,3 say "Ingrese la cantidad de dias :" get cantidad_dias picture "999"
        @ 4,38 say "Ingrese el codigo del cartucho :"
        read
        set key K_F1 to achoart
        @ 4,38 say "Ingrese el codigo del cartucho :" get elemento picture "99999" valid elem(elemento)
        xa=savescreen(0,0,24,80)
        read
        set key K_F1 to
        if lastkey()=27
                exit
        endif
        historia()
        select 3
enddo
return





function historia()
/////////////////// defino vector
declare hist[cantidad_dias+1]
for limpia=1 to (cantidad_dias+1)
        hist[limpia]=NIL
next limpia
select 1
set index to artalq_u
reindex
seek elemento
if found()=.f.
        set color to gr+/b
        @ 16,22 say " ESTE CARTUCHO TODAVIA NO TIENE HISTORIA "
        set color to
        inkey(0)
        restscreen(0,0,24,80,xa)
        return
endif        
x=0
comienza=date()-cantidad_dias
do while codalq=elemento
        if alquil<comienza
                skip
        else
                x=x+1
                aux=codsoc
                select 2
                seek aux
                nombre=nomsoc
                telefono=telsoc
                select 1
                hist[x]=dtoc(alquil)+" "+str(codsoc)+" "+nombre+telefono
                skip
        endif
enddo
if x<>0
        @ 9,1 to 23,78 double
        set color to w+/b
        @ 10,2 say "Alquil¢    Socio                                       Tel‚fono             "
        set color to 
        achoice(11,2,22,77,hist)
        restscreen(0,0,24,80,xa)
else
        @ 12,20 to 14,60 double
        set color to w+/b
        @ 13,21 say " ESTE CARTUCHO NO REGISTRA MOVIMIENTOS "
        set color to
        wait''
        restscreen(0,0,24,80,xa)
endif
return

















function achoart()
select 3
cadena=""
set key K_F1 to vacia2art
set key K_F8 to vacia2art
vv=readvar()
if vv<>"ELEMENTO"
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
dbedit(9,10,18,70,ac,"ach",,AC2)  // consulta por nombres
set color to
IF tcla=1 // si toco enter
	restscreen(0,0,24,80,ppa)
        AUXI=nroart
        set index to maeart_c
        seek auxi
        elemento=auxi  // nroart
	KEYBOARD CHR(13)
else      
	set index to 
        keyboard chr(K_F8) // ultimoart()
END IF
restscreen(0,0,24,80,ppa)
set key K_F1 to achoart
set key K_F8 to 
set index to maeart_c
RETURN




FUNCTION ach(NMODO)
	LOCAL NTECLA:=LASTKEY()
	LOCAL NVALRET:=DE_CONT   // para que devuelva que continua
	DO CASE
		CASE NMODO==DE_HITTOP  // si va al top
                        TONE (100,1)
		CASE NMODO==DE_HITBOTTOM  // si va al bottom
                        TONE (100,1)
		CASE NMODO==DE_EXCEPT  // si toca una tecla
                        NVALRET:=ach2(NTECLA)  // va a la funcion ach2
		CASE NTECLA=5 .OR. NTECLA=24  // si es flecha abajo o arriba
                        CADENA=""  // borra concatenacion de cadena
			set color to w*/n
			@ 20,13 SAY REPLICATE(" ",36)
			@ 20,13 say "_"
			set color to
	END CASE

RETURN NVALRET  //retorna si continua o no

FUNCTION ach2(NTECLA)
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


