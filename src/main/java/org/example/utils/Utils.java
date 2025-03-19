package org.example.utils;

import java.util.Random;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.ThreadLocalRandom;

public class Utils {
    private static final String ALPHABET = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz0123456789";

    public static String getRandomNumberDocumentCO() {
        Random random = new Random();
        if (random.nextBoolean()) {
            return String.valueOf(1 + random.nextInt(99999999)); // Genera un número entre 1 y 99999999
        } else {
            return String.valueOf(1000000000L + random.nextInt(1000000001)); // Genera un número entre 1000000000 y 2000000000
        }
    }

    // Método para generar una string aleatoria de longitud específica
    public static String generateRandomString(int length) {
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(ALPHABET.length());
            sb.append(ALPHABET.charAt(index));
        }
        return sb.toString();
    }

    // Método que genera un correo aleatorio en el formato requerido
    public static String generateRandomEmail() {
        String randomPart = generateRandomString(8); // Genera una parte aleatoria de 8 caracteres
        return "testingAPI_" + randomPart + "@gmail.com";
    }

    public static String getRandomDate() {
        LocalDate today = LocalDate.now();
        LocalDate maxDate = today.plusMonths(1);

        long randomEpochDay = ThreadLocalRandom.current().nextLong(today.toEpochDay(), maxDate.toEpochDay() + 1);
        LocalDate randomDate = LocalDate.ofEpochDay(randomEpochDay);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return randomDate.format(formatter);
    }

    public static String getRandomDateByDate(String startDate) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate start = LocalDate.parse(startDate, formatter);
        LocalDate maxDate = start.plusMonths(1);

        long randomEpochDay = ThreadLocalRandom.current().nextLong(start.toEpochDay(), maxDate.toEpochDay() + 1);
        LocalDate randomDate = LocalDate.ofEpochDay(randomEpochDay);

        return randomDate.format(formatter);
    }

    public static char getRandomTF() {
        Random random = new Random();
        return random.nextBoolean() ? 'T' : 'F';
    }

    public static int getRandomEven(int max) {
        Random random = new Random();
        int number;

        do {
            number = random.nextInt(max - 1) + 2; // Genera un número entre 2 y (max - 1)
        } while (number % 2 != 0); // Asegura que sea par

        return number;
    }
}
