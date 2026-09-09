pantalla:=savescreen(0,0,24,80)
clear
t1="ษอออออออออออออออออออออออออออออออออออออป"
t2="บ Para Volver al Sistema escriba EXIT บ"
t3="ศอออออออออออออออออออออออออออออออออออออผ"
c=40-(int(len(t1))/2)
@ 0,c say t1
@ 1,c say t2
@ 2,c say t3
run c:\command
restscreen(0,0,24,80,pantalla)
set path to \a&m
close databases
return
