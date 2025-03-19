@ignore
Feature: Setup feature

  Scenario:
    * def dataRandom = Java.type('org.example.utils.Utils')
    * def connectionDB = Java.type('org.example.utils.ConnectionDB')
    * def consultaSQL = Java.type('org.example.utils.ConsultasSQL')