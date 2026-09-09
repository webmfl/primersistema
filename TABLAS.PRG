close databases
set confirm on
#include "inkey.ch"        // incluye libreria control de teclas
@ 5,1 clear to 23,77       // PONE COLOR NEGRO VENTANA PRINCIPAL
set color to n/w*
mind="<< Abriendo ¡ndices - Espere un momento por favor >>"
co=40-(int(len(mind))/2)
@ 17,co say mind
///////////////////////// ACA COMIENZAN LOS SELECT'S
                select 1
use t_loca
set index to x_loca
                select 2
use t_rubr
set index to x_rubr
                select 3
use t_fabr
set index to x_fabr
                select 4
use t_tipo
set index to x_tipo
/////////////////////////////// FIN DE LOS SELECT'S
cabezal()
return


function cabezal()
do while .t.
        set key K_F1 to vacia2
        set key K_F2 to vacia2
        set key K_F10 to vacia2
        color="N"    // color blanco de fondo
        recuadro=1   // sin recuadro
        doble=0      // sin tipo de linea
        menuv=0      // sin menu ppal
        #include "fondo2.prg"
        set color to w+/bg
        @ 1,0 say "[Esc=Vuelve]                                                    Fecha:  /  /    "
        @ 1,70 say date()
        set color to
        t="´ M A N E J O   D E   T A B L A S Ã"
        cx=40-(int(len(t))/2)
        @ 2,cx say t

        set key K_F1 to vacia
                   
        @ 24,1 say"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        @ 5,3 to 10,20 double
        @ 6,4 prompt">LOCALIDADES   <"
        @ 7,4 prompt">RUBROS        <"
        @ 8,4 prompt">FABRICANTES   <"
        @ 9,4 prompt">TIPOS DE JUEGO<"
        menu to op_tab
        if lastkey()=27
                return
        endif
        do case
                case op_tab=1
                        select 1
                        leyen="<F1=Localidades>"
                        campos()
                case op_tab=2
                        select 2
                        leyen="<F1=Rubros>"
                        campos()
                case op_tab=3
                        select 3
                        leyen="<F1=Fabricantes>"
                        campos()
                case op_tab=4
                        select 4
                        leyen="<F1=Tipos de juego>"
                        campos()
        endcase
enddo
set confirm off

return








function campos()
vir=.t.
s=.t.
do while s=.t.
        
                  ///////// DEFINICION DE VARIABLES
        cd=1
        go bottom
        cd=cd+codigo
        go top
        cod_tab=cd
        des_tab=space(30)

        set cursor on
        @ 9,45 say"ÍÍÍÍÍÍÍÍÍÍÍÍ"
        set key K_F1 to consu
        @ 24,1 say leyen
        set key K_F10 to vacia
        
        /////// tengo habilitado el f1 solamente

        salva:=savescreen(19,10,23,70)
        @ 11,38 say replicate ("Ä",30)
        fl=0
        marca=0
        marc=0
        @ 9,37 to 14,68 double
        @ 10,38 say"CODIGO:"get cod_tab picture "99" valid cod(cod_tab)
        @ 12,38 say"DESCRIPCION:" 
        @ 13,38 get des_tab picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"   
        opci4:=savescreen(9,37,16,75)
        vir=.f.
        read
        if lastkey()=27
                return
        endif
//////// a esta altura estan habilitados f1 y f10 si encontro el codigo ///////
        
        xmen:=savescreen(17,16,19,46)
        @ 17,16 clear to 19,46
        @ 17,16 to 19,46
        @ 24,66 say"ÍÍÍÍÍÍÍÍÍÍÍÍ"
        @ 18,17 say"Confirma este ingreso"
        @ 18,41 prompt"SI"
        @ 18,44 prompt"NO"
        menu to opxx
        @ 17,16 clear to 19,46       //// borra mensaje
        do case 
                case opxx=1
                        if marc=0
                                append blank
                        endif
                        replace codigo with cod_tab, ;
                                descri with des_tab
                        cod_tab=cod_tab+1
                        des_tab=space(30)
                case opxx=2
                        cod_tab=0
                        des_tab=space(30)
        endcase
enddo
  











function cod(x)
if cod_tab=0 
        return .f.
endif
seek x
if found()
        ll=.t.
        marc=1
        set color to w+/b
        @ 9,56 say"[F10-Borrar]"         
        @ 10,46 say codigo
        cod_tab=codigo
        set color to n/w
        @ 13,38 say descri
        des_tab=descri
        set color to
        set key K_F10 to eliminar
else
        ll=.t.
        @ 9,56 say"ÍÍÍÍÍÍÍÍÍÍÍÍ"
        des_tab=space(30)
endif
set color to
return ll










function eliminar()
set key K_F1 to
set key K_F10 to 
set color to
set cursor on
@ 22,1 say replicate ("Ä",78)
set color to w+/n*
@ 23,2 say"Confirma ELIMINAR DEFINITIVAMENTE este c¢digo   "   
set color to
@ 23,50 say"º"
@ 23,65 prompt" CANCELAR "
@ 23,52 prompt" ACEPTAR "           
menu to opxx3
enco=.f.
do case
        case opxx3=2
                        @ 22,1 clear to 23,77
                        delete
                        pack
                        marc=0
endcase
@ 22,1 clear to 23,77
@ 9,56 say"ÍÍÍÍÍÍÍÍÍÍÍÍ"
cod_tab=0
des_tab=space(30)
set key K_F1 to consu
keyboard chr(5)
return 







function consu()
set color to
set key K_F1 to vacia2
safado=readvar()
if safado<>"COD_TAB"
        restscreen (19,10,23,70,salva)
        set key K_F1 to consu
        return
endif        
tot=0
tot=lastrec()        /////// saca el total de registros de la base activa
declare ayu[tot]
declare va[tot]
go top
for cic=1 to tot
        cad=str(codigo)+" ³"+descri
        ayu[cic]=cad
        va[cic]=codigo
        skip
next cic
if tot=0                     ////// si la base esta vacia
        set color to n*/w
        set cursor off
        xs:=savescreen(21,0,21,80)
        titut=" << No hay datos en esta base >> "
        cc=40-(int(len(titut)/2))
        @ 21,cc say titut
        inkey(3)
        @ 21,cc say "                                 "
        set cursor on
        set color to
        restscreen(21,0,21,80,xs)

else    
        @ 19,10 to 23,70 double 
        K=.T.
        DO WHILE K=.T.
                xpo=achoice(20,11,22,69,ayu)
                do case
                case lastkey()=27 
                        restscreen (19,10,23,70,salva)
                        set key K_F1 to consu
                        return
                case lastkey()=13
                        cod_tab=va[xpo]
                        k=.f.
                otherwise
                        k=.t.
                end case
        enddo
end if
restscreen (19,10,23,70,salva)
keyboard chr(13)
set key K_F1 to consu
return






FUNCTION VACIA()
RETURN






