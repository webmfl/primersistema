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

///////////// defino vector
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
//////////////////////////////// FIN DE LOS SELECT'S



set index to maesoc_c
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
t="´ Historia del socio Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t                                                                 // ÉÍ> Se conecta con RASCAR.PRG
@ 24,1 say "[F1=Socios]"
do while .t.
        socel=0                                                                   // ºÍ> le rutina elem que valida
        set key K_F1 to ayudas
        @ 4,3 say "Ingrese el codigo del socio :" get socel picture "99999" valid fsocel(socel)
        xa=savescreen(0,0,24,80)
        read
        set key K_F1 to
        if lastkey()=27
                exit
        endif
        histosoc()
        select 2
enddo
return





function fsocel(x)
select 2
seek x
if found()
        @ 8,10 say "Buscando:"
        set color to w+/n*
        @ 8,20 say nomsoc picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        set color to
        x=.t.
else
        x2:=savescreen(20,0,23,80)
        set color to b/bg*
        set cursor off
        @ 23,1 say "                       ­Ese n£mero de Socio no existe!                        "
        inkey(4)
        set color to
        set cursor on
        restscreen(20,0,23,80,x2)
        x=.f.
endif
return x






function histosoc()
for limpia=1 to 1200
        hist[limpia]=NIL
next limpia
select 1
set index to movsoc_a
reindex
seek socel
if found()=.f.
        set color to gr+/b
        @ 16,24 say " ESTE SOCIO TODAVIA NO TIENE HISTORIA "
        set color to
        inkey(0)
        restscreen(0,0,24,80,xa)
        return
endif        
x=0
do while codsoc=socel
                x=x+1
                aux=codalq
                select 3
                set index to maeart_c
                seek aux
                nombre=nomart
                devol=estart
                select 1
                hist[x]=str(aux)+" "+nombre+" "+dtoc(alquil)
                skip
enddo
@ 9,1 to 23,78 double
set color to w+/b
@ 10,2  say "Cartuchos"
@ 10,50 say "Total al   /  /  :"
@ 10,59 say date()
@ 10,69 say x picture "9999"
set color to 
asort(hist)
achoice(11,2,22,77,hist)
restscreen(0,0,24,80,xa)
return










function ayudas()
select 2
cadena=""
set key K_F1 to
vv=readvar()
if vv<>"SOCEL"
	RETURN .T.
END IF
go top
ac:={"NROSOC","NOMSOC"}
AC2:={"N§ SOCIO","NOMBRE"}
ppa=savescreen(0,0,24,80)
set cursor off
set color to w*/n
@ 20,13 SAY REPLICATE(" ",36)
@ 20,13 say "_"
set color to
set index to maesoc_n  // abre indice de nombres
reindex
set cursor on
set color to n+/bg+
@ 22,9 say " Consulta de Socios  - Ctrl+PgUp=Principo - Ctrl+PgDw=Final "
@ 8,9 to 19,71
@ 19,9 to 21,71
@ 19,9 say "Ã"
@ 19,71 say "´"
dbedit(9,10,18,70,ac,"achx",,AC2)  // consulta por nombres
set color to
IF tcla=1 // si toco enter
	restscreen(0,0,24,80,ppa)
        AUXI=nrosoc
        set index to maesoc_c
        seek auxi
        socel=auxi  // nrosoc
        KEYBOARD CHR(13)
else      
	set index to 
END IF
restscreen(0,0,24,80,ppa)
set key K_F1 to ayudas
set index to maesoc_c
RETURN




FUNCTION achx(NMODO)
	LOCAL NTECLA:=LASTKEY()
	LOCAL NVALRET:=DE_CONT   // para que devuelva que continua
	DO CASE
		CASE NMODO==DE_HITTOP  // si va al top
                        TONE (100,1)
		CASE NMODO==DE_HITBOTTOM  // si va al bottom
                        TONE (100,1)
		CASE NMODO==DE_EXCEPT  // si toca una tecla
                        NVALRET:=ach2x(NTECLA)  // va a la funcion ach2x
		CASE NTECLA=5 .OR. NTECLA=24  // si es flecha abajo o arriba
                        CADENA=""  // borra concatenacion de cadena
			set color to w*/n
			@ 20,13 SAY REPLICATE(" ",36)
			@ 20,13 say "_"
			set color to
	END CASE

RETURN NVALRET  //retorna si continua o no

FUNCTION ach2x(NTECLA)
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

