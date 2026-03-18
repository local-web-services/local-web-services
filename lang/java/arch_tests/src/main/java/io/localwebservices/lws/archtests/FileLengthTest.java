package io.localwebservices.lws.archtests;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.fail;

/**
 * Enforces that main source files are no longer than 500 lines, mirroring the Python radon/ruff
 * file-length limit.
 */
public class FileLengthTest extends ArchTestBase {

    private static final int MAX_LINES = 500;

    @Test
    void mainSourceFilesMustNotExceedMaxLines() throws IOException {
        Path srcRoot = getSrcRoot();
        List<String> violations = new ArrayList<>();

        for (Path file : findJavaFiles(srcRoot)) {
            long lineCount = Files.lines(file).count();
            if (lineCount > MAX_LINES) {
                violations.add(
                        file.getFileName()
                                + " — "
                                + lineCount
                                + " lines (max "
                                + MAX_LINES
                                + ")");
            }
        }

        if (!violations.isEmpty()) {
            fail(
                    "File length violations found:\n"
                            + String.join("\n", violations)
                            + "\n\nSource files in src/main/ must be ≤"
                            + MAX_LINES
                            + " lines.");
        }
    }
}
