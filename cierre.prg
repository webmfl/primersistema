cls
///////////////// CREA MOVDIA.DBF & INDICES MOVFAL_Q,MOVSOC_A,ARTALQ_U,MOVFDE_V
if .not. file("hisdia.dbf")                      // (3)
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
        dbcreate("hisdia",campo)
endif
//////////////////////////// ACA COMIENZAN LOS SELECT'S
select 1
        use movdia
        index on alquil to alq_ind
        set index to alq_ind
select 2
        use hisdia
        // set index to maesoc_c,maesoc_n
select 1
var_ALQUIL=ctod("  /  /    ")
var_CODSOC=0
var_CODALQ=0
var_PREALQ=0
var_DEUALQ=0
var_FDEVAL=ctod("  /  /    ")
var_DEVUEL=ctod("  /  /    ")
var_RECALQ=0
var_FECVAR=ctod("  /  /    ")
var_DESVAR=space(35)
var_VARIOS=0
go top
set century on
set date french
fecha_inicio=ctod("  /  /    ")
fecha_final=ctod("  /  /    ")
fuera="no"
@ 5,5 say "Fecha cierre desde:" get fecha_inicio
@ 6,5 say "Fecha cierre hasta:" get fecha_final
read
do while .t.
        seek fecha_inicio
        if found()
                do while .not. eof()  
                        var_ALQUIL=ALQUIL
                        var_CODSOC=CODSOC
                        var_CODALQ=CODALQ
                        var_PREALQ=PREALQ
                        var_DEUALQ=DEUALQ
                        var_FDEVAL=FDEVAL
                        var_DEVUEL=DEVUEL
                        var_RECALQ=RECALQ
                        var_FECVAR=FECVAR
                        var_DESVAR=DESVAR
                        var_VARIOS=VARIOS
                        select 2
                        append blank
                        replace alquil with var_ALQUIL, ;
                        codsoc with var_CODSOC, ;
                        codalq with var_CODALQ, ;
                                prealq with var_PREALQ, ;
                                deualq with var_DEUALQ, ;
                                fdeval with var_FDEVAL, ;
                                devuel with var_DEVUEL, ;
                                recalq with var_RECALQ, ;
                                fecvar with var_FECVAR, ;
                                desvar with var_DESVAR, ;
                                varios with var_VARIOS
                                commit
                        select 1
                        delete
                        inicio=str(day(fecha_inicio))+" de "+cmonth(fecha_inicio)+" de "+str(year(fecha_inicio))
                        final=str(day(fecha_final))+" de "+cmonth(fecha_final)+" de "+str(year(fecha_final))
                        mensaje3="Moviemiento del d¡a:"+dtoc(alquil)
                        columna3=(80-len(mensaje3))/2
                        mensaje="Cerrando desde el "+inicio+" hasta "+final
                        columna=(80-len(mensaje))/2
                        set color to b*/w
                        @ 10,columna say mensaje
                        set color to b/w
                        @ 11,columna3 say mensaje3
                        skip
                        if alquil>fecha_final
                                fuera="si"
                                exit
                        endif
                enddo
        else
                fecha_inicio=fecha_inicio+1
                skip
        endif
        if fuera="si"
                exit
        endif
enddo
mensaje2="Cierre terminado - datos trasladados con exito a base historica"
columna2=(80-len(mensaje2))/2
set color to
cls
set color to n/w+
@ 11,columna2 say mensaje2
set color to
pack
quit
