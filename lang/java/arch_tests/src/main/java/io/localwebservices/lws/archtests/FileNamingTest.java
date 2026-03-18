package io.localwebservices.lws.archtests;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.fail;

/**
 * Enforces that test files end in Test.java or Steps.java. Main source files must end in .java
 * with a class name that does not look like a test.
 */
public class FileNamingTest extends ArchTestBase {

    @Test
    void testFilesMustEndInTestOrSteps() throws IOException {
        Path testsRoot = getTestsRoot();
        List<String> violations = new ArrayList<>();

        for (Path file : findJavaFiles(testsRoot)) {
            String name = file.getFileName().toString();
            boolean isTestFile = name.endsWith("Test.java") || name.endsWith("Steps.java");
            boolean isResourceFile = name.endsWith("Context.java") || name.endsWith("Hooks.java");
            boolean isRunnerFile = name.endsWith("RunnerTest.java");
            boolean isSupportFile = name.endsWith("Client.java") || name.endsWith("World.java");
            if (!isTestFile && !isResourceFile && !isRunnerFile && !isSupportFile) {
                violations.add(
                        file.getFileName()
                                + " — test-source file must end in Test.java, Steps.java,"
                                + " Context.java, Hooks.java, Client.java, or World.java");
            }
        }

        if (!violations.isEmpty()) {
            fail(
                    "File naming violations found:\n"
                            + String.join("\n", violations)
                            + "\n\nTest files must follow naming conventions.");
        }
    }
}
