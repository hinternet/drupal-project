@api
# language: es
Requisito: anónimo
    Como usuario anónimo no debo poder acceder a la página de administración
    ni a la creación de contenidos

  Antecedentes:
    Dado que soy un usuario anónimo
    Cuando voy a "/admin"
    Entonces debo obtener una respuesta HTTP con código "403"

  Esquema del escenario: Creación de contenidos
    Cuando voy a "/node/add/<content_type>"
    Entonces debo obtener una respuesta HTTP con código "403"

    Ejemplos:
      | content_type |
      | page         |
      | article      |


  Escenario: Visitar la portada
    Cuando voy a "/"
    Entonces debo obtener una respuesta HTTP con código "200"

  Escenario: Visitar la página de inicio de sesion
    Cuando voy a "/user/login"
    Entonces debo obtener una respuesta HTTP con código "200"
