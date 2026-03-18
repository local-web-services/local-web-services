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
 * Detects catch blocks with empty bodies in src/main/ source files. Mirrors Python's
 * pylint/ruff no-bare-except rule.
 */
public class NoBareExceptionsTest extends ArchTestBase {

    private static final Pattern EMPTY_CATCH =
            Pattern.compile("catch\\s*\\([^)]+\\)\\s*\\{\\s*\\}", Pattern.DOTALL);

    @Test
    void mainSourceMustNotHaveEmptyCatchBlocks() throws IOException {
        Path srcRoot = getSrcRoot();
        List<String> violations = new ArrayList<>();
        String[] lines;

        for (Path file : findJavaFiles(srcRoot)) {
            String content = readFile(file);
            Matcher matcher = EMPTY_CATCH.matcher(content);
            while (matcher.find()) {
                int pos = matcher.start();
                lines = content.substring(0, pos).split("\n");
                int lineNum = lines.length;
                violations.add(
                        file.getFileName()
                                + ":"
                                + lineNum
                                + " — empty catch block found");
            }
        }

        if (!violations.isEmpty()) {
            fail(
                    "Empty catch block violations found:\n"
                            + String.join("\n", violations)
                            + "\n\nCatch blocks in src/main/ must not be empty.");
        }
    }
}
