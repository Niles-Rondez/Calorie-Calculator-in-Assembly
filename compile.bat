set projectName=Main
\masm32\bin\ml /c /Zd /coff Main.asm
\masm32\bin\Link /SUBSYSTEM:CONSOLE Main.obj
Main.exe