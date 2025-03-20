package org.example.utils;

public enum ConsultasSQL {

    CONSULT_USER_BY_ID("""
            Select  * from  usuarios WHERE id_usuario = '%s'
            """),
    DELETE_USER_TEST("""
            Delete from  usuarios where id_usuario = '%s'
            """),
    RANDOM_TOURNAMENT("""
            SELECT * from TORNEOS  ORDER BY RANDOM() FETCH FIRST 1 ROW ONLY
            """),
    RANDOM_ID_GAMES("""
            SELECT * from video_juegos  ORDER BY RANDOM() FETCH FIRST 1 ROW ONLY
            """),
    RANDOM_PLATFORM("""
            SELECT * from plataformas ORDER BY RANDOM() FETCH FIRST 1 ROW ONLY
            """),
    RANDOM_CATEGORY("""
            SELECT * from categorias ORDER BY RANDOM() FETCH FIRST 1 ROW ONLY
            """),
    RANDOM_EQUIPO("""
            select * from equipos ORDER BY RANDOM() FETCH FIRST 1 ROW ONLY
            """);

    private String consulta;

    ConsultasSQL(String consulta) {
        this.consulta = consulta;
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
