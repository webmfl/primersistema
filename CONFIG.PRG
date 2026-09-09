do while .t.
        color="N+"    // color blanco de fondo
        recuadro=0   // sin recuadro
        doble=0      // sin tipo de linea
        menuv=0      // sin menu ppal
        #include "fondo.prg"
        set color to w+/b+
        @ 0,0 say "                                                                                "
        @ 0,0 say titulo_gral
        set color to n+/bg
        set key 28 to nadac2
        set message to 24 center
        set wrap on
        pp:=savescreen(1,1,24,80)
        @ 1,0 say"                                                                                 "
        @ 1,0  prompt" Datos Principales "
        @ 1,20 prompt" Herramientas "
        menu to op4
        if lastkey()=27
                exit
        endif
        do case
                case op4=1
                        do parame
                case op4=2
                        do herram
        endcase
enddo
return



function nadac2()
return
