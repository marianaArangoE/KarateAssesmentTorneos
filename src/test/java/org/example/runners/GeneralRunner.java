package org.example.runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class GeneralRunner {

    private static final String PATH_ROOT = System.getProperty("user.dir");

    public static void testParallel(String path, int threads, String flows, String tags){
        Results results = Runner.path(PATH_ROOT + path)
                .outputCucumberJson(true)
                .tags(tags)
                .parallel(threads);
        generateReport(results.getReportDir(), flows);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    private static void generateReport(String karateOutputPath, String flows) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), flows + "test in API torneo");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
