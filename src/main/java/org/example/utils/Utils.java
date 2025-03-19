package org.example.utils;

import java.util.Random;

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
}
