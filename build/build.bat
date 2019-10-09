@echo off
echo.

:: Standalone build
curl -fsSL -o q.lib https://github.com/KxSystems/kdb/raw/master/w64/q.lib    || goto :error

::keep original PATH, PATH may get too long otherwise
set OP=%PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
cl /LD /DKXVER=3 /Ferand.dll ../src/rand.c ../src/SobolSeq1024.c ../src/mt19937arcok.c q.lib
cl /LD /DKXVER=3 /Fenorm.dll ../src/norm.c ../src/ndist.c q.lib
set PATH=%OP%

move *.dll %QHOME%\w64\

exit /b 0
:error
exit /b %errorLevel%
