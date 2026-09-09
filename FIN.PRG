clear
close databases
@ 4,21 to 6,58
a1="<<   MFL SISTEMAS   >>"
t1=int(40-len(a1)/2)
@ 4,t1 say a1

a6="Espere un momento por favor"
a7="Se est  cerrando su sistema"
t6=int(40-len(a6)/2) 
t7=int(40-len(a7)/2) 
@ 12,t6 say a6
@ 13,t7 say a7
erase LISAUX.DBF
erase ARTAUX.DBF
erase SOCAUX.DBF
erase RANKING.DBF
erase ORDEN_R.NTX
erase X.NTX
erase MAESOC_C.NTX
erase MAESOC_N.NTX
erase MAEART_C.NTX
erase MAEART_N.NTX
erase ARTALQ_U.NTX
erase MOVFAL_Q.NTX
erase MOVSOC_A.NTX
erase MOVFDE_V.NTX
erase GANANC_F.NTX
erase X_LOCA.NTX
erase X_FABR.NTX
erase X_RUBR.NTX
erase X_TIPO.NTX
erase STKMOV_A.NTX
clear
quit
