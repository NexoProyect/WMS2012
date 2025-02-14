# Script de Escalamiento de Privilegios Windows Multipoint Server 2012 - 2012 Premium

Este repositorio contiene un script en formato `.bat` diseñado para realizar múltiples intentos de escalamiento de privilegios en sistemas Windows. El script intenta explorar diversas técnicas de escalamiento, como la ejecución de tareas programadas con privilegios elevados, la modificación de permisos en directorios del sistema, la manipulación de configuraciones de UAC, y más.

## Descripción del Script

El script realiza las siguientes acciones:

1. **Comprobar tareas programadas con privilegios elevados**: Busca tareas programadas que se ejecuten con privilegios elevados y muestra los resultados.
   
2. **Crear tarea programada con privilegios SYSTEM**: Intenta crear una tarea programada que se ejecute con privilegios SYSTEM para intentar ejecutar comandos con los máximos privilegios disponibles.
   
3. **Ejecutar tarea programada**: Si la tarea programada se creó correctamente, el script intentará ejecutarla para escalar privilegios.

4. **Modificar permisos en directorios críticos**: Intenta modificar los permisos del directorio `System32` y el archivo `cmd.exe` para permitir la escritura y ejecución, respectivamente.

5. **Ejecutar cmd.exe como administrador**: Intenta ejecutar `cmd.exe` con privilegios elevados (administrador).

6. **Comprobar configuración de UAC (Control de Cuentas de Usuario)**: Verifica si el UAC está habilitado en el sistema.

7. **Deshabilitar UAC**: Si tiene permisos suficientes, intenta deshabilitar el UAC para evitar restricciones adicionales en la ejecución de comandos elevados.

8. **Comprobar la ejecución de scripts de PowerShell**: Verifica si la ejecución de scripts de PowerShell está permitida en el sistema.

9. **Ejecutar un payload de PowerShell**: Si la ejecución de scripts de PowerShell está permitida, intenta ejecutar un payload PowerShell con el fin de obtener acceso elevado.

10. **Finalización**: Al finalizar, el script mostrará el resultado de todas las acciones ejecutadas y si el escalamiento de privilegios fue exitoso o no.

## Uso

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/NexoProyect/WMS2012.git
```
2. Ejecutar wms2012.bat

# Nota
Si no obtuviste info relevante puedes ejecutar perm.bat para saber con cuales permisos cuentas en tu usuario y asi abusar de eso.
