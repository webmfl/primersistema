//                  10        20        30        40        50        60        70        80
//        012345678901234567890123456789012345678901234567890123456789012345678901234567890
do while .t.
        a=0
        si=.f.
        public color
        public recuadro
        public doble
        public menuv
        close databases   // cierra todas las bases abiertas
        color="W"    // color blanco de fondo
        recuadro=0   // sin recuadro
        doble=0      // sin tipo de linea
        menuv=0      // sin menu ppal
        #include "fondo.prg"
        set color to w+/b+
        @ 0,0 say "                                                                                "
        @ 0,0 say titulo_gral
        ps:=savescreen(0,0,24,80)
        password()
        if si=.f.
                return
        endif
        restscreen(0,0,24,80,ps)
        set wrap on
        set color to n+/bg
        @ 1,0 say"                                                                                 "
        @ 1,0  prompt" Maestro Art¡culos "
        @ 1,20 prompt" Maestro Socios "  
        @ 1,37 prompt" Maestros del Sistema "
        do while .t.
                menu to op
                if lastkey()=27 .and. a=0
                        a=0
                        exit
                else
                        do case
                                case op=1
                                        a=1
                                        do maeart
                                        exit
                                case op=2
                                        a=1
                                        do maesoc
                                        exit
                                case op=3
                                        a=1
                                        do tablas
                                        exit
                        endcase
                endif
        enddo
        if lastkey()=27 .and. a=0
                exit
        endif
enddo
                






function password()
use parame
set color to
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
                IF LASTKEY()=27
                        si=.f.
                        return
                END IF
                CO=0
                NUME=STR(NUM)
                Z=LEN(NUMe)
                FOR X=1 TO Z
                        CO=CO+ASC(SUBSTR(NUMe,X,1))
                NEXT X
                IF CO=PASS
                        si=.t.
                        return
                END IF
        END DO
else
         si=.t.
END IF
return


