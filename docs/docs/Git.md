
Git/Ramas/PR

En Mitma trabajamos con los repositorios alojados en Azure Devops del ministerio
, la metodología de trabajo es:



1. Primero crearemos nuestra tarea en <a
href="https://fomentogobes.visualstudio.com/Portal.Web.DrupalAWS/_boards/directory"
target="_blank">Azure DevOps Boards</a>
2. Crearemos una rama para nuestra tarea:

    ````
    git checkout develop;
    ````

    ````
    git pull origin develop;
    ````

    ````
    git checkout -b feature/nombre_descriptivo;
    ````

3. Realizaremos nuestros cambios, realizando los commits siguiendo <a
href="https://www.conventionalcommits.org/en/v1.0.0/#summary" target="_blank">
Conventional commits</a>

4. Traeremos y resolveremos los cambios de la rama ``develop`` resolviendo
conflictos:

    ````
    git checkout develop;
    ````

    ````
    git pull origin develop;
    ````

    ````
    git checkout feature/nombre_descriptivo;
    ````

    ````
    git merge develop --no-ff;
    ````

5. Solucionados los conflictos o si no hubiere publicamos nuestra rama en remoto
con los últimos cambios
    ````
    git push origin feature/nombre_descriptivo;
    ````

6. Vamos a <a
href="https://fomentogobes.visualstudio.com/Portal.Web.DrupalAWS/_git/Cedex/pullrequests"
target="_blank">Azure DevOps pullrequests</a> y creamos el pull request

7. Una vez aceptado el pull request, debemos borrar las ramas tanto en local
como en remoto
