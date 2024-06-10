if not exist Compressed mkdir Compressed

cd Compressed
if exist *.hfm del *.hfm

copy ..\..\..\Graphics\Background*.*
copy ..\..\..\Graphics\*.spr

FOR %%i IN (*.*) DO ..\..\..\..\Tools\huffmunch\huffmunch -B %%i %%i.hfm

del mk.bat.hfm
del *.col
del *.pat
del *.scn
del *.spr

cd ..

..\..\..\Tools\BinToAsm Compressed\Background1.col.hfm Background1Col.s
..\..\..\Tools\BinToAsm Compressed\Background1.pat.hfm Background1Pat.s
..\..\..\Tools\BinToAsm Compressed\Background1.scn.hfm Background1Scn.s
..\..\..\Tools\BinToAsm Compressed\Background2.col.hfm Background2Col.s
..\..\..\Tools\BinToAsm Compressed\Background2.pat.hfm Background2Pat.s
..\..\..\Tools\BinToAsm Compressed\Background2.scn.hfm Background2Scn.s
..\..\..\Tools\BinToAsm Compressed\Background3.col.hfm Background3Col.s
..\..\..\Tools\BinToAsm Compressed\Background3.pat.hfm Background3Pat.s
..\..\..\Tools\BinToAsm Compressed\Background3.scn.hfm Background3Scn.s
..\..\..\Tools\BinToAsm Compressed\Sprites.spr.hfm Sprites.s

if exist *.obj del *.obj
if exist *.lst del *.lst
