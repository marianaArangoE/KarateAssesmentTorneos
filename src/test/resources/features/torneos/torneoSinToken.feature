@torneos
Feature: Testeo para el servio de torneos

  Background:
    * url baseUrl
    * path torneos

  @VerTorneos
  Scenario Outline: Ver torneos con diferentes configuraciones

    * param ViewAll = <ViewAll>
    * param Order = <Order>

    When method GET
    * print response
    And status 200

    Examples:
      | ViewAll | Order  |
      | 'true'  | 'DESC' |
      | 'true'  | 'ASC'  |
      | 'false' | 'DESC' |
      | 'false' | 'ASC'  |

  @TrearTorneoPorId
  Scenario Outline: Traer informacion de un torneo por ID

    * def query = connectionDB.getConsult(consultaSQL.RANDOM_TOURNAMENT.concatenarDato())
    * print query

    * def idTorneo = query.id_torneo[0]

    * path idTorneo
    When method GET
    * print response
    And status 200

    * print response

    And match response.nombre == query.nombre[0]

    Examples:
      | Iteraciones |
      | 1           |
      | 1           |
      | 1           |
