package io.localwebservices.lws.archtests;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.fail;

/**
 * Detects @Disabled annotations in test classes. Tests must never be silently skipped;
 * configure CI to provide required dependencies instead.
 */
public class NoSkippedTestsTest extends ArchTestBase {

    @Test
    void testsMustNotBeDisabled() throws IOException {
        Path testsRoot = getTestsRoot();
        List<String> violations = new ArrayList<>();
        String[] lines;

        for (Path file : findJavaFiles(testsRoot)) {
            String content = readFile(file);
            if (!content.contains("@Disabled")) {
                continue;
            }
            lines = content.split("\n");
            for (int i = 0; i < lines.length; i++) {
                String trimmed = lines[i].trim();
                if (trimmed.startsWith("@Disabled")) {
                    violations.add(
                            file.getFileName()
                                    + ":"
                                    + (i + 1)
                                    + " — @Disabled annotation found");
                }
            }
        }

        if (!violations.isEmpty()) {
            fail(
                    "@Disabled violations found:\n"
                            + String.join("\n", violations)
                            + "\n\nTests must never be skipped. Configure CI to provide required"
                            + " dependencies.");
        }
    }
}
