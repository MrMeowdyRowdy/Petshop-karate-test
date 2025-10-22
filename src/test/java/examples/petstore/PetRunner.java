package examples.petstore;

import com.intuit.karate.Runner;
import com.intuit.karate.core.KarateStats;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

class PetRunner {

    @Test
    void runAllWithCucumberReport() {
        KarateStats stats = Runner.path("classpath:examples/petstore")
                .outputCucumberJson(true)
                .parallel(1);

        assertEquals(0, stats.getFailCount(), stats.getErrorMessages());
        generateReport(stats.getReportDir());
    }

    private static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = jsonFiles.stream()
                .map(File::getAbsolutePath)
                .collect(Collectors.toList());

        assertFalse(jsonPaths.isEmpty(), "No Cucumber JSON files found for report generation");

        Configuration config = new Configuration(new File("target"), "Petshop-karate-test");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
