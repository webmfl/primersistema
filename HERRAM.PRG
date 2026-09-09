do while .t.
        close databases
        set color to
        @ 2,20 prompt"Eliminar Datos          "
        @ 3,20 prompt"Bajar datos al Disk     "
        @ 4,20 prompt"Levantar datos del Disk "
        @ 5,20 prompt"Ventana D.O.S.          "
        menu to herramientas
        if lastkey()=27
                exit
        endif
        do case
                case herramientas=1
                        do elidat
                case herramientas=2
                        do bajdis
                        return
                case herramientas=3
                        do levdis
                        return
                case herramientas=4
                        do comman
        endcase
enddo
return
