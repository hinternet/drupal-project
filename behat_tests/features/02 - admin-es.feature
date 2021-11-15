@api
# language: es
Requisito: admin
    Como usuario administrador debo poder acceder a la página de administración
    a la creación de contenidos y al menú de administración

  Antecedentes:
    Dado que soy un usuario anónimo
    Cuando voy a "/user/login"
    Cuando relleno con "administrator_test" a "edit-name"
    Cuando relleno con "test" a "edit-pass"
    Cuando pulso el botón "Iniciar sesión"
    Entonces debo obtener una respuesta HTTP con código "200"
    Cuando voy a "/admin"
    Entonces debo obtener una respuesta HTTP con código "200"

  Esquema del escenario: Creación de contenidos
    Cuando voy a "/node/add/<content_type>"
    Entonces debo obtener una respuesta HTTP con código "200"

    Ejemplos:
      | content_type |
      | page         |
      | article      |
