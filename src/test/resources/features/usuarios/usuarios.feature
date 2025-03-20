@Usuario
Feature: validacion de los usuarios

  Background:
    * url baseUrl
    * path usuarios
    * def responseExpected = read('classpath:assets/usuarios/responseUsuarios.json')


  @ignore
    @CrearUsuarioRequest
  Scenario: Crear un nuevo usuario de forma satisfactoria
    * def idUsuario = karate.get('idUsuario')
    * def nombre =  karate.get('nombre')
    * def correo =  karate.get('correo')
    * def contrasena =  karate.get('contrasena')
    * def apodo =  karate.get('apodo')
    * def equiposIdEquipo =  connectionDB.getConsult(consultaSQL.RANDOM_EQUIPO.concatenarDato()).id_equipo[0]

    * print idUsuario

    * def bodyCreateUser = read('classpath:assets/usuarios/crearUsuario.json')
    * print bodyCreateUser

    And request bodyCreateUser
    When method POST
    * print response

#    Examples:
#      | idUsuario                              | nombre                                       | correo                           | contrasena                              | apodo                              | equiposIdEquipo |
#      | dataRandom.getRandomNumberDocumentCO() | 'Usuario'+dataRandom.generateRandomString(4) | dataRandom.generateRandomEmail() | 'PS'+dataRandom.generateRandomString(4) | dataRandom.generateRandomString(3) | null            |


  @CrearUsuario&Eliminar
  Scenario Outline: Crear usuario y eliminarlo de la base de datos
    * def idUsuario = <idUsuario>
    * def nombre = <nombre>
    * def correo =  <correo>
    * def contrasena = <contrasena>
    * def apodo =  <apodo>
    * def equiposIdEquipo =  <equiposIdEquipo>


    * def requestCreate = call read('classpath:features/usuarios/usuarios.feature@CrearUsuarioRequest'){idUsuario:#(idUsuario),nombre:#(nombre),correo:#(correo),contrasena:#(contrasena),apodo:#(apodo),equiposIdEquipo:#(equiposIdEquipo)}
    * print requestCreate


    And match requestCreate.responseStatus == 201
    And match requestCreate.response.usuario.message == responseExpected.responseCrearUsuario

    * def query = connectionDB.getConsult(consultaSQL.CONSULT_USER_BY_ID.concatenarDato(idUsuario))
    * print query
    And assert query.id_usuario.length == 1

    * def query = connectionDB.getConsult(consultaSQL.DELETE_USER_TEST.concatenarDato(idUsuario))
    * print query


    Examples:
      | idUsuario                              | nombre                                       | correo                           | contrasena                              | apodo                              | equiposIdEquipo |
      | dataRandom.getRandomNumberDocumentCO() | 'Usuario'+dataRandom.generateRandomString(4) | dataRandom.generateRandomEmail() | 'PS'+dataRandom.generateRandomString(4) | dataRandom.generateRandomString(3) | null            |


  @CrearUsuarioConCamposVacios
  Scenario Outline: Crear usuario con Campos vacios por <caso>
    * def idUsuario = <idUsuario>
    * def nombre = <nombre>
    * def correo =  <correo>
    * def contrasena = <contrasena>
    * def apodo =  <apodo>
    * def equiposIdEquipo =  <equiposIdEquipo>


    * def requestCreate = call read('classpath:features/usuarios/usuarios.feature@CrearUsuarioRequest'){idUsuario:#(idUsuario),nombre:#(nombre),correo:#(correo),contrasena:#(contrasena),apodo:#(apodo),equiposIdEquipo:#(equiposIdEquipo)}
    * print requestCreate

    And match requestCreate.responseStatus == 400


    Examples:
      | caso         | idUsuario                              | nombre                                       | correo                           | contrasena                              | apodo                              | equiposIdEquipo |
      #|| dataRandom.getRandomNumberDocumentCO() | 'Usuario'+dataRandom.generateRandomString(4) | dataRandom.generateRandomEmail() | 'PS'+dataRandom.generateRandomString(4) | dataRandom.generateRandomString(3) | null            |
      | 'idUsuario'  | ''                                     | 'Usuario'+dataRandom.generateRandomString(4) | dataRandom.generateRandomEmail() | 'PS'+dataRandom.generateRandomString(4) | dataRandom.generateRandomString(3) | null            |
      | 'nombre'     | dataRandom.getRandomNumberDocumentCO() | ''                                           | dataRandom.generateRandomEmail() | 'PS'+dataRandom.generateRandomString(4) | dataRandom.generateRandomString(3) | null            |
      | 'correo'     | dataRandom.getRandomNumberDocumentCO() | 'Usuario'+dataRandom.generateRandomString(4) | ''                               | 'PS'+dataRandom.generateRandomString(4) | dataRandom.generateRandomString(3) | null            |
      | 'contrasena' | dataRandom.getRandomNumberDocumentCO() | 'Usuario'+dataRandom.generateRandomString(4) | dataRandom.generateRandomEmail() | ''                                      | dataRandom.generateRandomString(3) | null            |

  @Login
  Scenario Outline: Logearse de forma satisfactoria
    * def idUsuario = <idUsuario>
    * def nombre = <nombre>
    * def correo =  <correo>
    * def contrasena = <contrasena>
    * def apodo =  <apodo>
    * def equiposIdEquipo =  <equiposIdEquipo>

    * def requestCreate = call read('classpath:features/usuarios/usuarios.feature@CrearUsuarioRequest'){idUsuario:#(idUsuario),nombre:#(nombre),correo:#(correo),contrasena:#(contrasena),apodo:#(apodo),equiposIdEquipo:#(equiposIdEquipo)}
    * print requestCreate


    And match requestCreate.responseStatus == 201
    And match requestCreate.response.usuario.message == responseExpected.responseCrearUsuario

    * def query = connectionDB.getConsult(consultaSQL.CONSULT_USER_BY_ID.concatenarDato(idUsuario))
    * print query
    And assert query.id_usuario.length == 1

    * path 'login'
    * def bodyUser = read('classpath:assets/usuarios/requestLogin.json')
    * print bodyUser

    And request bodyUser
    When method POST
    * print response

    And  status 200
    And response.message == 'Inicio de sesión exitoso'

#    * def query = connectionDB.getConsult(consultaSQL.DELETE_USER_TEST.concatenarDato(idUsuario))
#    * print query


    Examples:
      | idUsuario                              | nombre                                       | correo                           | contrasena                              | apodo                              | equiposIdEquipo |
      | dataRandom.getRandomNumberDocumentCO() | 'Usuario'+dataRandom.generateRandomString(4) | dataRandom.generateRandomEmail() | 'PS'+dataRandom.generateRandomString(4) | dataRandom.generateRandomString(3) | null            |
