@Registro
Feature: Testeo para el servio de torneos exclusivos con Token

  Background:
    * url baseUrl
    * path registro

#    * def responseExpected = read('classpath:assets/registros/responseRegistros.json')

  @RegistrarmeEnTorneo
  Scenario: Registrarme en un torneo
    * def requestCreate = call read('classpath:features/usuarios/usuarios.feature@Login')
    * print requestCreate

    * def tipo_inscripcion = dataRandom.getRandomOneOrTwo()

    * def query = connectionDB.getConsult(consultaSQL.RANDOM_TOURNAMENT.concatenarDato())
    * print query

    * def idTorneo = query.id_torneo[0]

    * def bodyCreateUser = read('classpath:assets/registros/requestRegistro.json')
    * print bodyCreateUser

    * path idTorneo
    * header Authorization = 'Bearer ' + requestCreate.response.token
    And request bodyCreateUser
    When method POST

   # Guardar la imagen binaria en un archivo QR.png
    * def qrImagePath = karate.write(response, 'qr-code.png')
    * print "QR guardado en:", qrImagePath

    And status 200