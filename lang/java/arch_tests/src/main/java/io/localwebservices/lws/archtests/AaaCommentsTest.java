package io.localwebservices.lws.archtests;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.fail;

/**
 * Enforces that test methods annotated with @Test contain // Arrange, // Act, and // Assert
 * comments, following the AAA pattern required by contributing/testing/UNIT.md.
 */
public class AaaCommentsTest extends ArchTestBase {

    private static final Pattern TEST_METHOD_PATTERN =
            Pattern.compile(
                    "@Test\\s+(?:(?:public|protected|void|\\w+)\\s+)*void\\s+(\\w+)\\s*\\([^)]*\\)"
                            + "\\s*\\{([^}](?:[^}]|\\{[^}]*\\})*?)\\}",
                    Pattern.DOTALL);

    @Test
    void testMethodsMustHaveAaaComments() throws IOException {
        Path testsRoot = getTestsRoot();
        List<String> violations = new ArrayList<>();

        for (Path file : findJavaFiles(testsRoot)) {
            String content = readFile(file);
            if (!content.contains("@Test")) {
                continue;
            }
            Matcher matcher = TEST_METHOD_PATTERN.matcher(content);
            while (matcher.find()) {
                String methodName = matcher.group(1);
                String body = matcher.group(2);
                if (!body.contains("// Arrange")
                        || !body.contains("// Act")
                        || !body.contains("// Assert")) {
                    violations.add(
                            file.getFileName()
                                    + "#"
                                    + methodName
                                    + " is missing // Arrange / // Act / // Assert comments");
                }
            }
        }

        if (!violations.isEmpty()) {
            fail(
                    "AAA comment violations found:\n"
                            + String.join("\n", violations)
                            + "\n\nTest methods must contain // Arrange, // Act, and // Assert"
                            + " comments.");
        }
    }
}
