run cls
run del *.seg
run ren *.dbf *.seg
run copy a:*.dbf
wait '>>> Operacion concluida, toque una tecla para volver al sistema <<<'
// run "copy *.dbf c:\sistema\bases"
// run "copia.bat"
return
