*pendiente de revisión, copiado de [redmine](http://redmine.hiberus.com/redmine/projects/ministerio-de-fomento-ams-grupo-iii-portales-web/wiki/%5BCEDEX%5D_Roles_y_permisos)

Este documento es provisonal y esta pendiente de validar por el cliente, o que
el cliente haga su propuesta.

A la hora de organziar los roles y permisos tenemos que tener en cuenta los
tipos de contenido, ya que tenemos contenidos que son concrestos de personas, y
otros más genéricos.

Los contenido son:

    Laboratorio.
    Línea de investigación (research).
    Equipamiento (equipment).
    Proyectos (en curso, realizados).


Contenidos generales:

    Noticias
    Eventos
    Banners
    Enlaces

La propuesta es que haya un usuario de laboratorio por cada laboratorio y que
tenga acceso al contenido del laboratorio y contenidos que cuelguen del mismo,
esto se tiene que ver porque la usar Azure AD lo mismo el cliente no lo permite
y se tiene que crear un sistema de permisos más complejos (usar taxonomías para
controlar la edicción de contenido).

Para los contenidos genéricos, que haya un rol que pueda crear Noticias,
Eventos, Banners, Enlaces, de tal forma que pueda haber varias persona que se
encarguen de ello.
