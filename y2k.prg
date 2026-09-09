close databases   // cierra todas las bases abiertas
cls
use movdia
set century on
set date french
go 25322
do while .not. eof()
        @ 1,1 say alquil
        if year(alquil)=1900
                dia=str(day(alquil))
                mes=str(month(alquil))
                ano=str(2000)
                auxiliar=ctod(dia+"/"+mes+"/"+ano)
                replace alquil with auxiliar
        endif
        skip
enddo


close databases   // cierra todas las bases abiertas

