# Config - SO

### Demo

![](https://media4.giphy.com/media/84XAqTELHbZyGDQ3Yf/giphy.gif)


 ## Configurar VSCode
- Instalar ultima version de [VSCode de 32bit](https://code.visualstudio.com/updates/v1_35) 
- Instalar extension: **C/C++ Intelisense en VSCode**
- Abrir  *.code-workspace:

![](https://media3.giphy.com/media/0l9YwIR1GHwfx8DGmx/giphy.gif)



- Vamos a usar las tareas de **VSCode** para las acciones en de nuestros modulos como compilar, correr, etc:

![](https://media3.giphy.com/media/qq0aMclUdF76YVYGg5/giphy.gif?cid=790b76116d0b3bfda7b9f02f516db6e77a0bfd67352263ad&rid=giphy.gif&ct=g)

-  Crear **Keybinds** para las tareas mas usadas

:ok_hand: Ya esta todo para empezar a codear



## Tests

El entorno soporta **CUnit**. El ``makefile`` de cada projecto tiene una regla _**test**_ que corre el binario del projecto con el argumento "test": 

``$ ./binario test ``

Esta regla es la que usa la tarea: **Test Project**. Si no entendes porque se corren asi los tests invito a que leas [esto](https://drive.google.com/file/d/1S5uSmkmKw66erjuHb7tb4UmDdklk8YaC/view "esto"). Basicamente el **main** del proyecto tiene que chequear si recibio como primer parametro "test", de ser asi los corre en vez del programa principal.

 :wrench: En la carpeta ``project/`` tenemos un ejemplo de como hay que configurar el **main** del proyecto para que corra los tests.



