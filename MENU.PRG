clear
do bases
use parame
titulo_gral=nombre
close databases
do while .t.
        setcancel(.t.)
        set epoch to 2000
        set date to french
        set confirm on
        set scoreboard off
        set century on
        public color
        public recuadro
        public doble
        public menuv
        declare menu[2,5]
        menu[1,1]:=" ALQUILER/VENTAS DIARIAS "
        menu[2,1]:="Registra los alquileres y ventas realizadas en el d¡a                  [Esc=Fin]"
        menu[1,2]:=" STOCK/COMPRAS           "
        menu[2,2]:="Registra las compras de mercader¡a y gastos generales                  [Esc=Fin]"
        menu[1,3]:=" MAESTROS GENERALES      "
        menu[2,3]:="Contiene los maestros necesarios para la utilizaci¢n del sistema       [Esc=Fin]"
        menu[1,4]:=" INFORMACION             "
        menu[2,4]:="Provee de listados e informaci¢n estad¡stica de su negocio             [Esc=Fin]"
        menu[1,5]:=" CONFIGURACION GENERAL   "
        menu[2,5]:="Configura y personaliza su sistema                                     [Esc=Fin]"
        fila=8
        pun=1
        color="W"
        recuadro=0
        doble=0
        menuv=1
        #include "fondo.prg"
        set color to w+/b+
        @ 0,0 say "                                                                                "
        @ 0,0 say titulo_gral
        @ fila,27  say menu[1,1]
        set color to b+/w+
        @ fila+1,27 say menu[1,2]
        @ fila+2,27 say menu[1,3]
        @ fila+3,27 say menu[1,4]
        @ fila+4,27 say menu[1,5]
        do while .t.
                keyboard chr(1)
                set cursor off
                set color to w+/b+ // pinta de azul
                @ 24,0 say menu[2,pun]
                @ 0,50 say"Fecha:"
                @ 0,56 say date()
                @ 0,66 say"-"
                @ 0,67 say"Hora:"
                @ 0,72 say time()
                set color to b+/w+ // pinta de gris
                do while .t.
                        inkey()
                        if lastkey()=5 .or. lastkey()=24 .or. lastkey()=13 .or. lastkey()=27
                                exit
                        endif
                        set color to w+/b+ // pinta de azul
                        @ 0,67 say"Hora:"
                        @ 0,72 say time()
                enddo
                if lastkey()=27 // si toca escape
                        set color to
                        pan:=savescreen(12,15,16,64)
                        @ 12,15 clear to 16,64
                        @ 13,15 say" ¨ Desea finalizar con la ejecuci¢n del sistema ? "
                        @ 15,30 prompt" ACEPTAR "
                        @ 15,40 prompt" CANCELAR "
                        menu to sal
                                do while .t.
                                        if sal=1
                                                do fin
						clear
                                                quit            
                                        elseif sal=2 .or. lastkey()=27
                                                restscreen(12,15,16,64,pan)
                                                exit
                                        endif
                                enddo
                elseif lastkey()=24 // flecha abajo
                        if fila=12
                                fila=8
                                pun=1
                                set color to w+/b+ // pinta de azul
                                @ fila,27 say menu[1,pun]
                                set color to b+/w+ // pinta de gris
                                @ fila+4,27 say menu[1,pun+4]
                        else
                                fila=fila+1
                                pun=pun+1
                                set color to b+/w+ // pinta de gris (inactivo)
                                @ fila-1,27 say menu[1,pun-1]
                                set color to w+/b+ // pinta de azul (activo)
                                @ fila,27 say menu[1,pun]
                        endif
                elseif lastkey()=5  // flecha arriba
                        if fila=8
                                fila=12
                                pun=5
                                set color to w+/b+ // pinta de azul
                                @ fila,27 say menu[1,pun]
                                set color to b+/w+ // pinta de gris
                                @ fila-4,27 say menu[1,pun-4]
                        else
                                fila=fila-1
                                pun=pun-1
                                set color to b+/w+ // pinta de gris (inactivo)
                                @ fila+1,27 say menu[1,pun+1]
                                set color to w+/b+ // pinta de azul (activo)
                                @ fila,27 say menu[1,pun]
                        endif
                elseif lastkey()=13 // selecciona con enter
                        do case
                                case pun=1
                                        do alquil
                                        exit
                                case pun=2
                                        do compra
                                        exit
                                case pun=3
                                        do maestr
                                        exit
                                case pun=4
                                        do inform
                                        exit
                                case pun=5
                                        do config
                                        exit
                        endcase
                endif
        enddo
enddo
quit
