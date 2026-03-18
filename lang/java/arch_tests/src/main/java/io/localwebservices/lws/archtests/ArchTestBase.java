package io.localwebservices.lws.archtests;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

/** Base class providing file scanning utilities for architecture tests. */
public abstract class ArchTestBase {

    protected Path getSrcRoot() {
        String srcRoot = System.getProperty("arch.src.root");
        if (srcRoot == null || srcRoot.isEmpty()) {
            throw new IllegalStateException(
                    "System property 'arch.src.root' must be set to the project's src/main/java/");
        }
        return Paths.get(srcRoot);
    }

    protected Path getTestsRoot() {
        String testsRoot = System.getProperty("arch.tests.root");
        if (testsRoot == null || testsRoot.isEmpty()) {
            throw new IllegalStateException(
                    "System property 'arch.tests.root' must be set to the project's"
                            + " src/test/java/");
        }
        return Paths.get(testsRoot);
    }

    protected List<Path> findJavaFiles(Path root) throws IOException {
        List<Path> files = new ArrayList<>();
        if (!Files.exists(root)) {
            return files;
        }
        try (Stream<Path> stream = Files.walk(root)) {
            stream.filter(p -> p.toString().endsWith(".java")).forEach(files::add);
        }
        return files;
    }

    protected String readFile(Path path) throws IOException {
        return Files.readString(path);
    }
}
