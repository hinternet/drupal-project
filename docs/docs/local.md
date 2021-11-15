## Preparación
1. Copia el archivo ``.env.dist`` a ``.env``
2. Copia el archivo ``docker-compose.override.yml.dist`` a
``docker-compose.override.yml``
3. Copia el archivo ``.vscode/extensions.json.dist`` a
``.vscode/extensions.json``
4. Copia el archivo ``.vscode/launch.json.dist`` a ``.vscode/launch.json``
5. Copia el archivo ``.vscode/settings.json.dist`` a ``.vscode/settings.json``

### Alternativa
1. Ejecuta el archivo desde el terminal:
````bash
bash scripts/prepare_local.sh
````
## Docker e instalación del proyecto
- Para arrancar los contenedores en tu equipo ejecuta:
``docker-compose up -d --build``
- Entramos en el contenedor usando ``docker-compose exec webapp bash``:
    - Ejecuta ``composer install`` para instalar todas las dependencias (por
    defecto
se ejecuta con ``--dev`` instalando también las dependencias de desarrollo)
    - Importa la base de datos: ``drush sql-cli < bd.sql``
    - Actualiza la base de datos e importa la configuración: ``drush deploy``
    - En algunas ocasiones puede ser necesario repetir la importación de la
    configuración varias veces con ``drush cim``
- Accede a [cedex.docker.localhost:8000](http://cedex.docker.localhost:8000)
