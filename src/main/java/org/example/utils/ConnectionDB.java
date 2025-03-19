package org.example.utils;

import java.sql.*;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConnectionDB {
    private static final Logger logger = Logger.getLogger(ConnectionDB.class.getName());

    private static Connection connection;
    private static final String URL = "jdbc:postgresql://ep-damp-fire-a4ujpbrj-pooler.us-east-1.aws.neon.tech/AssesmentTorneos";
    private static String userBD = System.getProperty("USER_POSTGRES_DB") != null && !System.getProperty("USER_POSTGRES_DB").isEmpty()
            ? System.getProperty("USER_POSTGRES_DB")
            : System.getenv("USER_POSTGRES_DB");
    private static String passBD = System.getProperty("PASSWORD_POSTGRES_DB") != null && !System.getProperty("PASSWORD_POSTGRES_DB").isEmpty()
            ? System.getProperty("PASSWORD_POSTGRES_DB")
            : System.getenv("PASSWORD_POSTGRES_DB");

    private ConnectionDB() {
    }

    public static void conectarDB() {
        try {
            // PostgreSQL no necesita registrar el driver manualmente
            connection = DriverManager.getConnection(URL, userBD, passBD);
            logger.log(Level.INFO, "Conexión exitosa a PostgreSQL");
        } catch (SQLException throwable) {
            logger.log(Level.WARNING, "Ocurrió un error al conectar con PostgreSQL");
            throwable.printStackTrace();
        }
    }

    public static Map<String, List<String>> getConsult(String query) {
        Map<String, List<String>> mapping = new LinkedHashMap<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet rs = preparedStatement.executeQuery()) {
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            while (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = metaData.getColumnName(i);
                    String value = rs.getString(i);
                    mapping.computeIfAbsent(columnName, k -> new LinkedList<>()).add(value);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.INFO, "Consulta falló al ser ejecutada");
            e.printStackTrace();
        }
        return mapping;
    }

    public static void cerrarDB() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                logger.log(Level.INFO, "Desconexión exitosa de PostgreSQL");
            }
        } catch (SQLException e) {
            logger.log(Level.INFO, "Error al cerrar la conexión a PostgreSQL");
            e.printStackTrace();
        }
    }
}
