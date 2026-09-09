close databases
#include "inkey.ch"        // incluye libreria control de taclas
color="N"    // color blanco de fondo
recuadro=1   // sin recuadro
doble=0      // sin tipo de linea
menuv=0      // sin menu ppal
#include "fondo2.prg"
set color to w+/bg
@ 1,0 say "[Esc=Vuelve]                                                      Fecha:  /  /  "
@ 1,72 say date()
set color to
t="´ Datos del comercio Ã"
cx=40-(int(len(t))/2)
@ 2,cx say t
use parame
set cursor on
oldpass=.t.
go 1
if pass>0
        salida=0
        pp:=savescreen(0,0,24,80)
        @ 10,24 clear to 13,56 
        for x=11 to 14 
                @ x,57 say "°°"
        next x
        @ 15,26 SAY REPLICATE ("°",33)
        nu=space(1)
        cx=44
        @ 10,25 TO 14,56 DOUBLE
        SET COLOR TO "N/W"
        @ 10,34 say "  PASSWORD  "
        SET COLOR TO 
        
                
        
        DO WHILE SALIDA=0 .AND. LASTKEY()<>27
                NUM=0
                @ 12,27 say "Ingrese Password:" get NUM PICTURE REPLICATE("9",10) color "n/n"
                READ
                CO=0
                NUME=STR(NUM)
                Z=LEN(NUMe)
                FOR X=1 TO Z
                        CO=CO+ASC(SUBSTR(NUMe,X,1))
                NEXT X
                IF CO=PASS
                        SALIDA=1
                END IF
        END DO
else
        IF RECCOUNT()=0
                APPEND BLANK
        END IF
        OLDPASS=.F.
END IF
IF LASTKEY()=27
return
END IF
IF OLDPASS=.T.
        SET KEY -8 TO borraf
        RESTSCREEN(0,0,24,80,PP)
        @ 3,1 CLEAR TO 23,77
        @ 2,1  say "[F10=Cambiar password]"
        @ 2,60 say "[F9=Borra password]"
ELSE
        @ 5,1 CLEAR TO 23,77
        @ 2,1 say "[F10=Poner password]ÄÄÄÄ"
END IF
SET KEY -9 TO NEW
CU=CUIT        
INI=INICIO
NOM=NOMBRE
PRO=PROPIE
TEL=TELEFONO
DI=DIRECCION
LOC=LOCALIDAD
PC=PCIA
PA=PASS     
@ 24,1 say "[Ctrl+Home=Inicio]ÄÄ[PgDn=Fin]ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ[Esc=Volver]"
PANTA:=SAVESCREEN(0,0,24,80)                           
INGRESO()
return


FUNCTION AMC()

FUNCTION ACEPTAR()      
RETURN






        
    

function borraf()
replace pass with 0
@ 2,1 say "[F10=Poner password]ÄÄÄÄ"
@ 2,60 say"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
return









function NEW()
LOCAL GETLIST:={}
P:=SAVESCREEN(0,0,24,80)
@ 3,1 CLEAR TO 23,78 
B=1
NUM=0
@ 12,17 TO 16,62 DOUBLE
for a=13 to 16
        @ a,63 say "±±"
NEXT A
@ 17,19 SAY REPLICATE("±",46)
SET COLOR TO "N/W"
@ 12,34 say "  PASSWORD  "
SET COLOR TO "W/N"
DO WHILE NUM<>B
        B=0
        @ 14,23 say "Ingrese nuevo Password:" GET B PICTURE REPLICATE("9",10) color "n/n"
        READ
        IF LASTKEY()=27
                RESTSCREEN(0,0,24,80,P)
                RETURN
        END IF
        NUM=0
        @ 14,22 SAY REPLICATE(" ",40)
        @ 14,19 say "Ingrese Password para confirmar:" GET NUM PICTURE REPLICATE("9",10) color "n/n"
        READ         
        IF LASTKEY()=27
                RESTSCREEN(0,0,24,80,P)
                RETURN
        END IF
        IF B<>NUM
                @ 14,19 SAY REPLICATE(" ",43)
                @ 14,31 SAY "Intente Nuevamente"
        END IF
        SET CURSOR OFF
        @ 23,2 SAY "Presione cualquier tecla para continuar . . ."
        INKEY(0)
        @ 14,19 SAY REPLICATE(" ",43)
        @ 23,2 SAY REPLICATE (" ",50)
        SET CURSOR ON
END DO
CO=0
NUME=STR(NUM)
Z=LEN(NUME)
FOR X=1 TO Z
        CO=CO+ASC(SUBSTR(NUME,X,1))
NEXT X
REPLACE PASS WITH CO
RESTSCREEN(0,0,24,80,P)
@ 2,1 say "[F10=Cambiar password]"
@ 2,60 say "[F9=Borra password]"
SET KEY -8 TO borraf
RETURN




FUNCTION INGRESO()
do while .t.
        @ 24,1 say "[Ctrl+Home=Inicio]ÄÄ[PgDn=Fin]ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ[Esc=Volver]"
        @ 4,4   say"NOMBRE DEL NEGOCIO:" get nom picture replicate ("!",50)
        @ 6,4   say"Domicilio:" get di picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        @ 8,4   say"Localidad:" get loc picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        @ 10,4  say"Provincia:" get pc picture "!!!!!!!!!!!!!!!!!!!!!!!!!"
        @ 12,4  say"Tel‚fono:" get tel picture "!!!!!!!!!!!!!!!"
        @ 14,4  say"Propietario:" get pro picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        @ 16,4  say"Inicio de Actividades:" get ini
        @ 18,4  say"C.U.I.T.:" get cu picture "99-99999999-9"
        read
        if lastkey()=27
                return
        endif
        pan=savescreen(17,16,19,46)
        @ 17,16 clear to 19,46
        @ 17,16 to 19,46
        @ 18,17 say"Confirma este ingreso"
        @ 18,41 prompt"SI"
        @ 18,44 prompt"NO"
        menu to opxx
        @ 0,0 say dbf()
        @ 17,16 clear to 19,46
        restscreen=(17,16,19,46,pan)
        do case 
                case opxx=1
                        REPLACE NOMBRE WITH NOM,;
                                DIRECCION WITH DI,;
                                LOCALIDAD WITH LOC,;
                                TELEFONO WITH TEL,;
                                PCIA WITH PC,;
                                PROPIE WITH PRO,;
                                INICIO WITH INI,;
                                CUIT WITH CU
                        commit
                        titulo_gral=ltrim(rtrim(nombre))
                        exit
                case opxx=2
                        CU=0
                        INI=ctod("  /  /  ")
                        NOM=space(35)
                        PRO=space(35)
                        TEL=space(15)
                        DI=space(25)
                        LOC=space(15)
                        PC=space(25)
        endcase                        
enddo
return




