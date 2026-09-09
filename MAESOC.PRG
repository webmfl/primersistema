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
public marc:={}

//// defino variables claves
tcla=0
N=1
confirmo=.t.
marc=0
set cursor off
mensa="<< Abriendo Maestro de Socios y respectivos ¡ndices >>"
col=40-(int(len(mensa))/2)
sxs:=savescreen(16,0,16,80)
set color to n/w*
@ 16,col say mensa
//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use maesoc
        set index to maesoc_c,maesoc_n
select 2
	use t_loca
	set index to x_loca
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
set color to
set cursor on
set key K_F2 to btabla()
do while .t.
        tocarrib=.f.
        marc=0
        desp=.f.
        if confirmo=.t.
                nro_socio=0
                nombre_socio=space(40)
                direccion_socio=space(35)
                telefono_socio=space(12)
                localidad_socio=0
                estado_socio=space(1)
                cp_socio=space(4)
                obs_socio=space(60)
                com_socio1=space(75)
                com_socio2=space(75)
                com_socio3=space(75)
                com_socio4=space(75)
                com_socio5=space(75)
        else
                set color to w+/b
                mens="< F6=Borrar >"
                cx=73-(int(len(mens))/2)
                @ 3,cx say mens
                set color to
        endif
        t="´ B A S E   D E   S O C I O S Ã"
        if confirmo=.t.
                @ 9,16 say replicate(" ",20)
        endif
        cx=40-(int(len(t))/2)
        @ 2,cx say t
        set key K_F1 to ayuda()
        @ 24,1  say"<F1=Socios>Ä<F2=Tablas>ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        set cursor on
        if confirmo=.t. 
                ultimo()
        endif
                set color to i
                @ 9,16 say replicate(" ",20)
                set color to 
                        @ 3,2  say "N§ de Socio:" get nro_socio picture ("99999") valid existe(nro_socio)
                        @ 5,5  say "Nombre y Apellido:" get nombre_socio picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                        @ 7,2  say "Direcci¢n:" get direccion_socio picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                        @ 7,50 say "Tel‚fono:" get telefono_socio
                        @ 9,2  say "Localidad:" get localidad_socio picture ("99") valid busca(localidad_socio)
                        @ 9,38 say "Activo:" get estado_socio picture "!" valid(estado_socio$"SN")
                        @ 9,50 say "C¢digo Postal:" get cp_socio picture ("!!!!")
                        @ 11,2 say "Observaciones:" get obs_socio picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                        @ 13,2 to 13,77 double
                        @ 15,2 say "Comentarios:"
                        @ 17,2 get com_socio1 picture replicate ("!",75)
                        @ 18,2 get com_socio2 picture replicate ("!",75)
                        @ 19,2 get com_socio3 picture replicate ("!",75)
                        @ 20,2 get com_socio4 picture replicate ("!",75)
                        @ 21,2 get com_socio5 picture replicate ("!",75)
                        read
                        eli:=savescreen(3,0,25,80)
                        read
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
                                                replace nrosoc with nro_socio, ;
                                                        nomsoc with nombre_socio, ;
                                                        dirsoc with direccion_socio, ;
                                                        telsoc with telefono_socio, ;
                                                        locsoc with localidad_socio, ;
                                                        estsoc with estado_socio, ;
                                                        c_psoc with cp_socio, ;
                                                        obssoc with obs_socio, ;
                                                        comen1 with com_socio1, ;
                                                        comen2 with com_socio2, ;
                                                        comen3 with com_socio3, ;
                                                        comen4 with com_socio4, ;
                                                        comen5 with com_socio5
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
                if confirmo=.t.
                        @ 9,16 say replicate(" ",20)
                endif
                mens="             "
                cx=73-(int(len(mens))/2)
                @ 3,cx say mens
        enddo
return









function existe(aux1)
// teclas=.f.
// if lastkey()=5
//         teclas=.t.
//         if nro_socio=0
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
//                         if nrosoc-1=aux1
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
//                                 esta=.f.
//                         else
//                                 aux1=aux1-1
//                         endif
//                 endif
//         enddo
// elseif lastkey()=24 .and. tocarrib=.t.
//         teclas=.t.
//         aux1=aux1+1
//         do while .t.
//                 seek aux1
//                 if found()
//                         exit
//                 else
//                         go bottom
//                         if nrosoc+1=aux1 .or. recno()=1
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
//                                 esta=.f.
//                         else
//                                 aux1=aux1+1
//                         endif
//                 endif
//         enddo
// endif
seek aux1
if found()
        marc=1    // marca para saber si es una modificacion o no
        xx:=savescreen(23,0,23,80)
        despliega()
        x=nrosoc
        set cursor off
        set color to w+/b
        mens="< F6=Borrar >"
        cx=73-(int(len(mens))/2)
        @ 3,cx say mens
        set key K_F6 to borra()
        set cursor on
	set color to
	restscreen(23,0,23,80,xx)
        nro_socio=nrosoc
        nombre_socio=nomsoc
        direccion_socio=dirsoc
        telefono_socio=telsoc
        localidad_socio=locsoc
        cp_socio=c_psoc
        estado_socio=estsoc
        obs_socio=obssoc
        com_socio1=comen1
        com_socio2=comen2
        com_socio3=comen3
        com_socio4=comen4
        com_socio5=comen5
        esta=.T.
else
        @ 9,16 say replicate("Û",20)
        mens="             "
        cx=73-(int(len(mens))/2)
        @ 3,cx say mens
        despliega()
        nombre_socio=space(40)
        direccion_socio=space(35)
        telefono_socio=space(12)
        localidad_socio=0
        estado_socio=space(1)
        cp_socio=space(4)
        obs_socio=space(60)
        com_socio1=space(75)
        com_socio2=space(75)
        com_socio3=space(75)
        com_socio4=space(75)
        com_socio5=space(75)
        // if teclas=.f.
                 esta=.t.
        // else
        //         esta=.f.
        // endif
endif
set key K_F1 to 
@ 24,1  say"Ä<F2=Tablas>ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
return esta








function despliega()
set color to n/w
@ 3,15  say nrosoc
@ 5,24  say nomsoc
@ 7,13  say dirsoc
@ 7,60  say telsoc
@ 9,13  say locsoc
@ 9,46  say estsoc
@ 9,65  say c_psoc
m=locsoc
desp=.t.
busca(m)
if m=0
        @ 9,16 say "                    "
endif        
select 1
set color to i
@ 11,17 say obssoc
@ 17,2 say comen1 picture replicate ("!",75)
@ 18,2 say comen2 picture replicate ("!",75)
@ 19,2 say comen3 picture replicate ("!",75)
@ 20,2 say comen4 picture replicate ("!",75)
@ 21,2 say comen5 picture replicate ("!",75)
set color to
return






function ayuda()
select 1
cadena=""
set key K_F1 to vacia2
set key K_F8 to vacia2
vv=readvar()
if vv<>"NRO_SOCIO"
	RETURN .T.
END IF
go top
ac:={"NROSOC","NOMSOC"}
AC2:={"N§ SOCIO","APELLIDO Y NOMBRE"}
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
@ 22,11 say " Consulta de Socios - Ctrl+PgUp=Principo - Ctrl+PgDw=Final "
@ 8,9 to 19,71
@ 19,9 to 21,71
@ 19,9 say "Ã"
@ 19,71 say "´"
dbedit(9,10,18,70,ac,"fun",,AC2)  // consulta por nombres
set color to
IF tcla=1 // si toco enter
	restscreen(0,0,24,80,ppa)
        AUXI=nrosoc
        set index to maesoc_c
        seek auxi
        nro_socio=auxi  // nrosoc
	KEYBOARD CHR(13)
else      
	set index to 
        keyboard chr(K_F8)
END IF        
restscreen(0,0,24,80,ppa)
set key K_F1 to ayuda()
set key K_F8 to ultimo
set index to maesoc_c
RETURN




FUNCTION FUN(NMODO)
	LOCAL NTECLA:=LASTKEY()
	LOCAL NVALRET:=DE_CONT   // para que devuelva que continua
	DO CASE
		CASE NMODO==DE_HITTOP  // si va al top
                        TONE (100,1)
		CASE NMODO==DE_HITBOTTOM  // si va al bottom
                        TONE (100,1)
		CASE NMODO==DE_EXCEPT  // si toca una tecla
			NVALRET:=FUN2(NTECLA)  // va a la funcion fun2
		CASE NTECLA=5 .OR. NTECLA=24  // si es flecha abajo o arriba
                        CADENA=""  // borra concatenacion de cadena
			set color to w*/n
			@ 20,13 SAY REPLICATE(" ",36)
			@ 20,13 say "_"
			set color to
	END CASE

RETURN NVALRET  //retorna si continua o no

FUNCTION FUN2(NTECLA)
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





function ultimo()
	go bottom
        nro_socio=nrosoc+1  // suma uno mas al ultimo numero de campo en la base
	go top
return





function vacia2()
return







function borra()
set key K_F6 to vacia2
                  //////////// SI ELIMINA  
@ 22,1 say replicate ("Ä",78)
set color to w+/n*
@ 23,2 say"Confirma ELIMINAR DEFINITIVAMENTE este socio ?  "
set color to
@ 23,50 say"º"
@ 23,65 prompt" CANCELAR "
@ 23,52 prompt" ACEPTAR "           
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
                nro_socio=0
                keyboard chr(27)
                restscreen(3,0,25,80,eli)
        case opxx3=1
                mens="             "
                cx=73-(int(len(mens))/2)
                @ 3,cx say mens
                @ 24,1 say "<F1=Socios>"
                // @ 2,60 say "<F8=Pr¢ximo c¢digo>"
                nro_socio=0
endcase
@ 21,1 clear to 23,78
set index to maesoc_c
reindex
return











function busca(m)
if desp=.t.
                select 2
		seek m
		if found()
                        set color to i
                        @ 9,16 say descri picture ("!!!!!!!!!!!!!!!!!!!!")
                        set color to
                        select 1
                        return .t.
                endif
endif
do case
         case readvar()="LOCALIDAD_SOCIO"
                select 2
                seek m
                if found()
                        set color to i
                        @ 9,16 say descri picture ("!!!!!!!!!!!!!!!!!!!!")
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





procedure btabla()
tec=readvar()
do case
        case tec="LOCALIDAD_SOCIO"
		tloc(1)
	otherwise
		notablas()
endcase
return








procedure notablas()
return





procedure tloc(vari)
set key K_F2 to vacia2
do case
	case vari=1
                select 2
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
	set key K_F2 to btabla()
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
		set key K_F2 to btabla()
		k=.f.
		return
	case lastkey()=13
		do case
			case vari=1
				loc_aux=tp2[xpos]
				select 1
                                localidad_socio=loc_aux
                endcase
		keyboard chr(13)
		restscreen (0,0,24,80,tapan)
                // do case
                //         case vari=1
                //                 @ 11,16 say tp3[xpos] picture replicate("!",20)
                // end case
		set key K_F2 to btabla()
		k=.f.
		return
	otherwise
		k=.t.
endcase
enddo
return

