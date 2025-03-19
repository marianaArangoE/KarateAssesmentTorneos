package org.example.runners;


import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.example.utils.ConnectionDB.cerrarDB;
import static org.example.utils.ConnectionDB.conectarDB;


class ParallelRunner {

    private final static String PATH = "/src/test/resources/features";

    private final static Integer THREADS = 1;

    private final static String FLOWS = "test parallel";

    private final static String TAGS = "~@ignore";

    @Test
    void testParallelRunner() {
        GeneralRunner.testParallel(PATH, THREADS, FLOWS, TAGS);
    }

    @BeforeEach
    void conectarseBD() {
        conectarDB();
    }

    @AfterEach
    void salirDB() throws SQLException {
        cerrarDB();
    }
}

