// muestro pantalla de presentacion
setcancel(.f.)
public undo_nombre:=""
public undo_importe:={}
undo_nombre="ANULADO"
undo_imporce=0
public fi:=0
public caracter:=0
public xbas:=1
public linpres:=0


////////////////////////////// rutina de seguridad
clear
run vol>mfl.txt
run attrib +h mfl.txt
run attrib -h mfl.dbf
clear
cadena=memoread("mfl.txt")
c1=val(substr(cadena,81,4))
c2=val(substr(cadena,86,2))
clave_ejecuta=c1*c2
if .not. file("mfl.dbf")
        set color to gr+/b
        set cursor off
        @ 12,18 say "ษอออออออออออออออออออออออออออออออออออออออออออป"
        @ 13,18 say "บ    Si necesita una copia legal de este    บ"
        @ 14,18 say "บ sistema comunกquese al 740-5648 >(Martกn) บ"
        @ 15,18 say "ศ1ออออออออออออออออออออออออออออออออออออออออออผ"
        inkey(0)
        set color to
        set cursor on
        quit
endif
run attrib +h mfl.dbf
use mfl
contra=clave
close databases
if clave_ejecuta<>contra
        set color to gr+/b
        set cursor off
        @ 12,18 say "ษอออออออออออออออออออออออออออออออออออออออออออป"
        @ 13,18 say "บ    Si necesita una copia legal de este    บ"
        @ 14,18 say "บ sistema comunกquese al 740-5648 >(Martกn) บ"
        @ 15,18 say "ศ2ออออออออออออออออออออออออออออออออออออออออออผ"
        inkey(0)
        set color to
        set cursor on
        quit
endif


/////////////////////////////////// si esta bien
set cursor off
clear
@ 21,19 to 23,60
@ 21,26 say "ด   0% de las Bases creadasร"
@ 22,20 say"ฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐ"
barra:=savescreen(22,20,22,59)
a1=space(10)
a2=space(10)
a3=space(10)
a4=space(10)
a5=space(10)
@ 4,21 to 6,58
a1="<<   MFL SISTEMAS   >>"
t1=int(40-len(a1)/2)
@ 4,t1 say a1

set color to w/n*
a6="Espere un momento por favor"
a7="Se est n creando las bases necesarias para el Sistema"
t6=int(40-len(a6)/2) 
t7=int(40-len(a7)/2) 
@ 12,t6 say a6
@ 13,t7 say a7

///////////////// CREA MAESOC.DBF & INDICES MAESOC_C/_N  (1)
if .not. file("maesoc.dbf")
        campo:={}
        aadd(campo,{"NROSOC","N",5,0})
        aadd(campo,{"NOMSOC","C",40,0})
        aadd(campo,{"DIRSOC","C",35,0})
        aadd(campo,{"TELSOC","C",12,0})
        aadd(campo,{"LOCSOC","N",2,0})
        aadd(campo,{"ESTSOC","C",1,0})
        aadd(campo,{"C_PSOC","C",4,0})     // codigo postal
        aadd(campo,{"OBSSOC","C",60,0})
        aadd(campo,{"COMEN1","C",75,0})
        aadd(campo,{"COMEN2","C",75,0})
        aadd(campo,{"COMEN3","C",75,0})
        aadd(campo,{"COMEN4","C",75,0})
        aadd(campo,{"COMEN5","C",75,0})
        dbcreate("maesoc",campo)
endif
use maesoc
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on nrosoc to maesoc_c
index on nomsoc to maesoc_n
xbas=1
dibujalinea()
///////////////// CREA MAEART.DBF & INDICES MAEART_C/_N    (2)
if .not. file("maeart.dbf")
        campo:={}
        aadd(campo,{"NROART","N",5,0})
        aadd(campo,{"NOMART","C",40,0})
        aadd(campo,{"FABART","N",2,0})
        aadd(campo,{"RUBART","N",2,0})
        aadd(campo,{"ESTART","C",1,0})
        aadd(campo,{"TIPART","N",2,0})
        aadd(campo,{"P_CART","N",6,2})  // precio de compra
        aadd(campo,{"P_AART","N",6,2})  // precio de alquiler
        aadd(campo,{"P_VART","N",6,2})  // precio de venta
        dbcreate("maeart",campo)
endif
use maeart
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on nroart to maeart_c
index on nomart to maeart_n
xbas=1
dibujalinea()
///////////////// CREA MOVDIA.DBF & INDICES MOVFAL_Q,MOVSOC_A,ARTALQ_U,MOVFDE_V
if .not. file("movdia.dbf")                      // (3)
        campo:={}
        aadd(campo,{"ALQUIL","D",8,0})
        aadd(campo,{"CODSOC","N",5,0})
        aadd(campo,{"CODALQ","N",5,0})
        aadd(campo,{"PREALQ","N",6,2})
        aadd(campo,{"DEUALQ","N",6,2})
        aadd(campo,{"FDEVAL","D",8,0})
        aadd(campo,{"DEVUEL","D",8,0})
        aadd(campo,{"RECALQ","N",6,2})
        aadd(campo,{"FECVAR","D",8,0})
        aadd(campo,{"DESVAR","C",35,0})
        aadd(campo,{"VARIOS","N",6,2})
        dbcreate("movdia",campo)
endif
use movdia
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on alquil to movfal_q
index on codsoc to movsoc_a
index on codalq to artalq_u
index on fdeval to movfde_v
xbas=1
dibujalinea()
///////////////// CREA STKMOV.DBF & INDICES STKMOV_A   (4)
if .not. file("stkmov.dbf")
        campo:={}
        aadd(campo,{"STKART","N",5,0})
        aadd(campo,{"STKFEC","D",8,0})
        aadd(campo,{"STKCOM","C",40,0})
        aadd(campo,{"STKING","N",6,0})
        aadd(campo,{"STKEGR","N",6,0})
        dbcreate("stkmov",campo)
endif
use stkmov
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on stkart to stkmov_a
xbas=1
dibujalinea()
/////////////////////////////////////// CREA LAS TABLAS STANDARDS
////////////////// CREA T_LOCA & INDICE X_LOCA         (5)
if .not. file("t_loca.dbf")
        campo:={}
        aadd(campo,{"CODIGO","N",2,0})
        aadd(campo,{"DESCRI","C",30,0})
        dbcreate("t_loca",campo)
endif
use t_loca
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on codigo to x_loca
xbas=xbas+1
dibujalinea()
////////////////// CREA T_RUBR & INDICE X_RUBR       (6)
if .not. file("t_rubr.dbf")
        campo:={}
        aadd(campo,{"CODIGO","N",2,0})
        aadd(campo,{"DESCRI","C",30,0})
        dbcreate("t_rubr",campo)
endif
use t_rubr
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on codigo to x_rubr
xbas=xbas+1
dibujalinea()
////////////////// CREA T_FABR & INDICE X_FABR       (7)
if .not. file("t_fabr.dbf")
        campo:={}
        aadd(campo,{"CODIGO","N",2,0})
        aadd(campo,{"DESCRI","C",30,0})
        dbcreate("t_fabr",campo)
endif
use t_fabr
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on codigo to x_fabr
xbas=xbas+1
dibujalinea()
////////////////// CREA T_TIPO & INDICE X_TIPO        (8)
if .not. file("t_tipo.dbf")
        campo:={}
        aadd(campo,{"CODIGO","N",2,0})
        aadd(campo,{"DESCRI","C",30,0})
        dbcreate("t_tipo",campo)
endif
use t_tipo
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on codigo to x_tipo
xbas=xbas+1
dibujalinea()

///////////parametros                             (9)
if .not. file("parame.dbf")
        campo:={}
        aadd(campo,{"NOMBRE","C",50,0})
        aadd(campo,{"DIRECCION","C",40,0})
        aadd(campo,{"LOCALIDAD","C",40,0})
        aadd(campo,{"PCIA","C",25,0})
        aadd(campo,{"TELEFONO","C",15,0})
        aadd(campo,{"PROPIE","C",35,0})
        aadd(campo,{"CUIT","N",13,0})
        aadd(campo,{"INICIO","D",8,0})
        aadd(campo,{"IVA","N",11,0})
        aadd(campo,{"PASS","N",10,0})
        dbcreate("parame",campo)
endif
xbas=xbas+1
dibujalinea()

///////////////// CREA GANANC.DBF & INDICES GANANC_F   (10)
if .not. file("gananc.dbf")
        campo:={}
        aadd(campo,{"GANFEC","D",8,0})
        aadd(campo,{"GANDES","C",60,0})
        aadd(campo,{"SOCIOV","N",5,0})
        aadd(campo,{"GANING","N",6,2})
        aadd(campo,{"GANEGR","N",6,2})
        dbcreate("gananc",campo)
endif
use gananc
set color to w+/n*
@ 22,20 say"          Ordenando Archivo...          "
set color to
index on ganfec to gananc_f
xbas=xbas+1
dibujalinea()

close databases
set color to
set cursor on

return





function dibujalinea()
caracter=int((xbas*40)/10)
p=(xbas*100)/10
restscreen(22,20,22,59,barra)
set color to 
@ 21,19 to 23,60
@ 21,26 say "ด    % de las Bases creadasร"
@ 21,28 say p picture "999"
@ 22,20 say replicate("Û",caracter)
barra:=savescreen(22,20,22,59)
set color to w/n*
return

