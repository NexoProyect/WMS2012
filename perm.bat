@echo off
setlocal enabledelayedexpansion

:: Definir los directorios y archivos críticos para verificar permisos
set DIRS_TO_CHECK="C:\Windows\System32 C:\Windows\System32\cmd.exe C:\Windows\System32\powershell.exe C:\Windows\System32\calc.exe C:\Windows\System32\winlogon.exe"

:: Verificar permisos de archivos y directorios críticos
echo [*] Verificando permisos de archivos y directorios críticos...
for %%I in (%DIRS_TO_CHECK%) do (
    echo Verificando %%I...
    icacls "%%I" >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo Permisos encontrados para %%I:
        icacls "%%I"
        echo [*] Si tienes permisos de escritura o ejecución, podrías abusar de estos permisos.
    ) else (
        echo [*] No se puede acceder a %%I o no existe.
    )
)

:: Comprobar si puedes modificar las tareas programadas
echo [*] Verificando tareas programadas...
schtasks /query /fo LIST /v | findstr /i "SYSTEM"
echo [*] Si tienes permisos sobre tareas programadas, puedes abusar de ellos para obtener privilegios elevados.

:: Enlace de referencia para más detalles sobre icacls y permisos:
echo [*] Más información sobre icacls: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls

:: Finalización del script
echo [*] Revisa los resultados anteriores para más detalles sobre los permisos y tareas programadas.
pause
