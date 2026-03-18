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
 * Detects hardcoded string literals used directly in assertion calls. Requires extracting
 * literals to named variables (expected_* / actual_*) per contributing/testing/COMMON.md.
 */
public class NoMagicStringsTest extends ArchTestBase {

    private static final Pattern ASSERTION_MAGIC_STRING =
            Pattern.compile(
                    "(?:assertEquals|assertThat|assertContains|assertEqualsIgnoreCase)"
                            + "\\s*\\(\\s*\"[^\"]{2,}\"",
                    Pattern.CASE_INSENSITIVE);

    @Test
    void assertionsMustNotUseMagicStrings() throws IOException {
        Path testsRoot = getTestsRoot();
        List<String> violations = new ArrayList<>();
        String[] lines;

        for (Path file : findJavaFiles(testsRoot)) {
            String content = readFile(file);
            lines = content.split("\n");
            for (int i = 0; i < lines.length; i++) {
                String line = lines[i];
                if (line.trim().startsWith("//")) {
                    continue;
                }
                Matcher matcher = ASSERTION_MAGIC_STRING.matcher(line);
                if (matcher.find()) {
                    violations.add(
                            file.getFileName()
                                    + ":"
                                    + (i + 1)
                                    + " — magic string literal in assertion: "
                                    + line.trim());
                }
            }
        }

        if (!violations.isEmpty()) {
            fail(
                    "Magic string violations found:\n"
                            + String.join("\n", violations)
                            + "\n\nExtract string literals to expected_* / actual_* variables.");
        }
    }
}
