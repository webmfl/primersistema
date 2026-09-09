close databases
#include "inkey.ch"
#include "achoice.ch"
/////////////////////////// vectores
declare socios[7]
declare cart[5]
declare estad[3]
socios[1]="Listado Socios"               // lissoc.prg
socios[2]="Socio mas alquilador"         // ransoc.prg
socios[3]="Historia del socio"           // hissoc.prg
socios[4]="Deudas generales"             // deusoc.prg
socios[5]="Deuda de cart. x socio"       // cardeu.prg
socios[6]="Deuda de cart. x fecha"       // deupoc.prg
socios[7]="Deudas de dinero"             // dindeu.prg
cart[1]="Listado de cartuchos"           // liscar.prg
cart[2]="Rastreo de cartuchos"           // rascar.prg
cart[3]="Historia de cartuchos"          // hiscar.prg
cart[4]="Los mas alquilados"             // rancar.prg
cart[5]="Tema mas alquilado"             // temcar.prg
estad[1]="Listado diario"                // lisdia.prg
estad[2]="Ingresos por deudas"           // ingdeu.prg
estad[3]="Ventas puntuales"              // venpun.prg
///////////////////////////////////////////////////////////////////


do while .t.
        color="n+"    // color blanco de fondo
        recuadro=0   // sin recuadro
        doble=0      // sin tipo de linea
        menuv=0      // sin menu ppal
        #include "fondo.prg"
        set color to w+/b+
        @ 0,0 say "                                                                                "
        @ 0,0 say titulo_gral
        set color to n+/bg
        set key KP_ALT_SLASH to
        set message to 24 center
        set wrap on
        pp:=savescreen(1,1,24,80)
        @ 1,0 say"                                                                                 "
        @ 1,0  prompt" Socios "
        @ 1,9  prompt" Cartuchos "
        @ 1,21 prompt" Estadistica "
        menu to op4
        set color to
        if lastkey()=27
                exit
        endif
        do case
                case op4=1
                        s:=achoice(2,0,8,21,socios)
                        if s=1
                                do lissoc
                        elseif s=2
                                do ransoc
                        elseif s=3
                                do hissoc
                        elseif s=4
                                do deusoc
                        elseif s=5
                                do cardeu
                        elseif s=6
                                do deupoc
                        elseif s=7
                                do dindeu
                        endif
                case op4=2
                        c:=achoice(2,9,6,29,cart)
                        if c=1
                                do liscar
                        elseif c=2
                                do rascar
                        elseif c=3
                                do hiscar
                        elseif c=4
                                do rancar
                        elseif c=5
                                do temcar
                        endif
                case op4=3
                        cla=.f.
                        set key KP_ALT_SLASH to clave
                        e:=achoice(2,21,4,41,estad)
                        if e=1
                                if cla<>.t.
                                        do lisdia
                                endif
                        elseif e=2
                                if cla<>.t.
                                        do ingdeu
                                endif
                        elseif e=3
                                if cla=.t.
                                        do venpun
                                endif
                        endif
        endcase
enddo
return




function clave()
keyboard chr(13)
cla=.t.
return






function albarra(nmodoa)
local nvaldev:=AC_CONT
local ntecla:=LASTKEY()
do case
        case nmodo==AC_IDLE
                do case
                        case a==3
                                @ 0,0 say "estoy aca"
                                set key KP_ALT_SLASH to clave
                        otherwise
                                set key KP_ALT_SLASH to
                endcase
endcase
return nvaldev

