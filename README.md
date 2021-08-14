# Config Inicial

- Instalar ultima version de [VSCode de 32bit](https://code.visualstudio.com/updates/v1_35) 
- Instalar extension: **C/C++ Intelisense en VSCode**

## Como Correr el TP

El makefile es el de [so-project-template](https://github.com/RaniAgus/so-project-template) con unas pequeñas modificaciones. Asi que se puede importar a Eclipse sin problemas (no serviria la carpeta .vscode) y usar el [so_deploy](https://github.com/sisoputnfrba/so-deploy).

### Correr dentro de  VSCode

En cada modulo esta la carpeta ``.vscode`` y dentro tiene el archivo ``tasks.json``. Este archivo nos permite basicamente automatizar cualquier cosa. Para no usar la consola externa se crean 5 tareas por modulo:

- *Modulo Build*
- *Modulo Run*
- *Modulo Run con Valgrind*
- *Modulo Run con Helgrind*
- *Modulo Test*

Para ejecutar cada una hay que ir a **Tareas -> Ejecutar Tarea** y seleccionar lo que queremos hacer.

Lo mas conveniente es crear un par de Keybinds en el archivo ``keybindings.json`` para hacer todo mas rapido, como por ejemplo: 

```c
/* Atajos para TP - Operativos*/
[
    {
        "key": "alt+shift+r alt+shift+p",  // ALT+SHIT+R+P "Run Project"
        "command": "workbench.action.tasks.runTask",
        "args": "Project Run"              // hace referencia a la tarea a ejecutar
    },
    {
        "key": "alt+shift+v alt+shift+p",  // ATL+SHIFT+V+P "Valgrind Project"
        "command": "workbench.action.tasks.runTask",
        "args": "Project Valgrind"
    },   
    {
        "key": "alt+shift+b alt+shift+p",
        "command": "workbench.action.tasks.runTask",
        "args": "Project Build"
    }, 
    {
        "key": "alt+shift+t alt+shift+p",
        "command": "workbench.action.tasks.runTask",
        "args": "Project Test"
    },
    {
        "key": "alt+shift+b alt+shift+u",
        "command": "workbench.action.tasks.runTask",
        "args": "Utils Build"
    },     
]
```

### Debug en VSCode

El archivo ``launch.json`` es el que nos deja debuggear en VSCode. Con solo apretar **F5** se puede Debuggear. **No olvidar los breakpoints**

___

### Correr en Consola Externa

Si en una terminal dentro de un modulo hacemos ``make help``, se imprime:

```
 make / make all -- Build project using debug flags.
 make project    -- Build project using release flags.
 make clean      -- Remove generated files from file system.
 make memcheck   -- Run using valgrind memcheck tool. Output will be redirected to an external log file.
 make helgrind   -- Run using valgrind helgrind tool. Output will be redirected to an external log file.
 make test       -- Run Project Tests
 make run        -- Run Project
```
Si no gusta el make siempre se puede hacer todo de manera manual. El binario se genera en ``bin/``



# Datos Importantes

- Siempre hacer ``make clean`` antes de hacer un *commit/push*. Asi no hay archivos innecesarios en el repositorio *(ej: el .log de valgrind)*. 
- No agregar al commit o hacer ``checkout`` de los archivos que no son necesarios actualizar y pueden crear conflictos absurdos. Ejemplo cuando hay cambios en el log y el config:
```bash
git checkout project/cfg project2/cfg 
```
