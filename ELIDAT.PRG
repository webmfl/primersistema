close databases
public exito:={}
top=adir("*.dbf")
declare bases[top]
adi:=directory("*.dbf")
for x=1 to top
        bases[x]=adi[x,1]
next x
eli:=savescreen(0,0,24,80)
@ 9,39 to 21,50 double
apos=achoice(10,40,20,49,bases)
do while .t.
        if lastkey()=27
                restscreen(0,0,24,80,eli)
                return
        elseif lastkey()=13
                eligio=bases[apos]
                exit
        endif
enddo
use parame
do while .t.
        if pass=0
                borrabase()
                return
        else
                pidepassword()
                if exito=.t.
                        borrabase()
                        return
                else                        
                        exit
                endif
        endif
enddo
close databases
return





function pidepassword()
passtrucho=0
t1="ษออออออออออออออออออออออออออออออออออออออออออออออออออออป"
t2="บ Por Favor, Tipee Clave de Acceso:                  บ"
t3="ศออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
cc=39-(int(len(t1))/2)
cc2=cc+len(t1)
@ 15,cc say t1
@ 16,cc say t2
@ 17,cc say t3
for posibil=1 to 3
        @ 16,cc+38 get passtrucho color "n/n"
        read
        if lastkey()=27
                exito=.f.
                @ 15,1 clear to 17,77
                @ 9,39 clear to 21,50 
                return
        endif
        co=0
        nume=str(passtrucho)
        z=len(nume)
        for x=1 to z
                co=co+asc(substr(nume,x,1))
        next x
        if co=pass
                @ 15,1 clear to 17,77
                exito=.t.
                exit
        else
                exito=.f.
                error="[Clave Errขnea-Reintente]"
                c2=27-(int(len(error))/2)
                set color to w+/n*
                @ 15,c2 say error 
                set color to 
        endif
next posibil
@ 15,1 clear to 17,77
@ 9,39 clear to 21,50 
return 





function borrabase()
use &eligio
n=dbf()
extension=".DBF"
archivo=n+extension
archivo=alltrim(archivo)
t1="ษออออออออออออออออออออออออออออออออออออออออออออออออป"
t2="บ Est  seguro de elimnar los datos de            บ"
t3="ศออออ[Enter:Confirma]ออออออออออ[Esc:Cancela]อออออผ"
cc=39-(int(len(t1))/2)
cc2=cc+len(t1)
@ 15,cc say t1
@ 16,cc say t2
@ 17,cc say t3
set cursor off
@ 16,52 say archivo
do while .t.
        inkey(0)
        if lastkey()=27
                set cursor on
                @ 9,39 clear to 21,50 
                @ 15,1 clear to 17,77
                return
        elseif lastkey()=13
                @ 15,1 clear to 17,77
                delete
                zap
                a1="ษอออออออออออออออออออออออออป"
                a2="บ Base            vaciada บ"
                a3="ศอออออออออออออออออออออออออผ"
                cc=39-(int(len(a1))/2)
                cc2=cc+len(t1)
                set color to w+/n
                @ 15,cc say a1
                @ 16,cc say a2
                @ 17,cc say a3
                @ 16,31 say archivo
                set color to 
                inkey(3)
                set cursor on
                @ 9,39 clear to 21,50 
                @ 15,1 clear to 17,77
                exit
        endif
enddo
restscreen(0,0,24,80,eli)
close databases
return
