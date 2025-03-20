@torneos
Feature: Testeo para el servio de torneos exclusivos con Token

  Background:
    * url baseUrl
    * path torneos

    * def responseExpected = read('classpath:assets/torneos/responseTorneos.json')


  @CrearTorneo
  Scenario: Crear un torneo nuevo con Token

    * def requestCreate = call read('classpath:features/usuarios/usuarios.feature@Login')
    * print requestCreate

    * def nombre = "Test_"+dataRandom.generateRandomString(5)
    * def fechaInicio = dataRandom.getRandomDate()
    * def fechaFin = dataRandom.getRandomDateByDate(fechaInicio)
    * def videoJuegosId = connectionDB.getConsult(consultaSQL.RANDOM_ID_GAMES.concatenarDato()).id[0]
    * def itsFree = dataRandom.getRandomTF()
    * def limiteEquipos = dataRandom.getRandomEven(20)
    * def limiteViews = dataRandom.getRandomEven(1000)
    * def plataformaId = connectionDB.getConsult(consultaSQL.RANDOM_PLATFORM.concatenarDato()).id_plataforma[0]
    * def categoriasId = connectionDB.getConsult(consultaSQL.RANDOM_CATEGORY.concatenarDato()).id_categoria[0]
    * def descripcion = "Desc"+dataRandom.generateRandomString(5)

    * def bodyCreateUser = read('classpath:assets/torneos/requestCrearTorneo.json')
    * print bodyCreateUser

    * path '/crearTorneo'
    * header Authorization = 'Bearer ' + requestCreate.response.token
    And request bodyCreateUser
    When method POST
    * print response
    And status 200
    And match response.message == responseExpected.TorneoCreadoCorrectamente

  @ActualizarTorneo
  Scenario: Actualizar torneo
    * def requestCreate = call read('classpath:features/torneos/torneosConToken.feature@CrearTorneo')
    * print requestCreate


    * def fecha_inicio_new = dataRandom.getRandomDate()
    * def fecha_fin_new = dataRandom.getRandomDateByDate(fecha_inicio_new)
    * def descripcion_new = "Desc_Update"+dataRandom.generateRandomString(10)

    * def bodyCreateUser = read('classpath:assets/torneos/requestUpdateTournament.json')
    * print bodyCreateUser

    * path '/update/'+ requestCreate.response.id_torneo
    * header Authorization = 'Bearer ' + requestCreate.requestCreate.response.token
    And request bodyCreateUser
    When method PUT
    * print response
    And status 200
#    And match response.message == responseExpected.TorneoCreadoCorrectamente
