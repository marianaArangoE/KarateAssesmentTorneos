package org.example.utils;

public enum ConsultasSQL {

    CONSULT_USER_BY_ID("""
            Select  * from  usuarios WHERE id_usuario = '%s'
            """),
    DELETE_USER_TEST("""
            Delete from  usuarios where id_usuario = '%s'
            """);

    private String consulta;

    ConsultasSQL(String consulta) {
        this.consulta = consulta;
    }

    public String executeQuery(String... argumentos) {
        String newQuery = this.consulta;
        for (String concat : argumentos) {
            newQuery = newQuery.replaceFirst("%s", concat);
        }
        return newQuery;
    }

    public String replaceAllBy(String argumentos) {
        return this.consulta.replace("%s", argumentos);
    }

    public String buildQuery(String... params) {
        return String.format(this.consulta, (Object[]) params);
    }

    public String getConsulta() {
        System.out.println(this.consulta);
        return this.consulta;
    }

    public String concatenarDato(String... argumentos) {
        String newQuery = this.consulta;
        for (String concat : argumentos) {
            newQuery = newQuery.replaceFirst("%s", concat);
        }
        return newQuery;
    }

}
