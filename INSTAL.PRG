clear
run vol>mfl.txt
run attrib +h mfl.txt
run del mfl.dbf
cadena=memoread("mfl.txt")
c1=val(substr(cadena,81,4))
c2=val(substr(cadena,86,2))
? c1
? c2
clave_acceso=c1*c2
if .not. file("mfl.dbf")
        campo:={}
        aadd(campo,{"CLAVE","N",10,0})
        dbcreate("mfl",campo)
endif
use mfl
append blank
replace clave with clave_acceso
close databases
run attrib +h mfl.dbf
wait
quit

                 
