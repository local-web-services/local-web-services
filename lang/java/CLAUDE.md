# Java Language Implementation — Conventions

This document is the authoritative reference for the Java implementation's
testing strategy, Makefile targets, CI structure, and shared tooling. Read it
before writing or modifying anything under `lang/java/`.

---

## Directory Layout

```
lang/java/
├── arch_tests/      Shared architecture constraint tests (JAR consumed by all three projects)
│   ├── build.gradle
│   ├── settings.gradle
│   └── src/main/java/io/localwebservices/lws/archtests/
├── config/          Shared quality tool config (referenced by all three build.gradle files)
│   ├── checkstyle/checkstyle.xml
│   ├── pmd/pmd-ruleset.xml
│   └── spotbugs/exclude.xml
├── core/            AWS emulator server — com.sun.net.httpserver handlers
│   ├── src/main/java/io/localwebservices/lws/
│   ├── src/test/java/io/localwebservices/lws/
│   ├── src/architectureTest/java/io/localwebservices/lws/
│   ├── src/test/resources/         Feature files + Cucumber config
│   ├── build.gradle
│   ├── gradlew
│   └── Makefile
├── sdk/             Testing SDK for user projects
│   ├── src/main/java/io/localwebservices/lws/
│   ├── src/test/java/io/localwebservices/lws/
│   ├── src/architectureTest/java/io/localwebservices/lws/
│   ├── src/test/resources/
│   ├── build.gradle
│   └── Makefile
├── example/         Reference project demonstrating SDK usage
│   ├── src/architectureTest/java/com/example/orders/
│   ├── build.gradle
│   └── Makefile
└── Makefile         Root cascading Makefile
```

---

## Java Version

The canonical Java version is `17` (Temurin distribution, as configured in CI
via `actions/setup-java`). Every `build.gradle` under `lang/java/` must set
`sourceCompatibility = JavaVersion.VERSION_17`. Do not hard-code a version
anywhere else.

---

## Build Tool

All three packages use Gradle via the `gradlew` wrapper. Never call `gradle`
directly — always use `./gradlew` to ensure the pinned wrapper version is used.

CI sets `GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-<project>"`
to avoid build directory conflicts between projects running in the same workspace.

---

## Test Types and Ownership

| Test type | Core | SDK | Example |
|---|---|---|---|
| `unit / bdd` | `src/test/java/` (JUnit 5 + Cucumber) | `src/test/java/` (JUnit 5 + Cucumber) | `src/test/java/` (JUnit 5 + Cucumber) |
| `architecture` | `src/architectureTest/java/` | `src/architectureTest/java/` | `src/architectureTest/java/` |

All test types are run together via `./gradlew test`. There is no separate
unit vs BDD split — JUnit 5 runs Cucumber via the Cucumber JUnit Platform Engine.

Architecture tests run separately via `./gradlew architectureTest`.

Feature files (`.feature`) live in `src/test/resources/` within each project,
referencing the canonical specs from `lang/specification/core/informal/<service>/`.

---

## Makefile Targets

### Standard targets — must exist in `core/`, `sdk/`, and `example/`

| Target | Description |
|---|---|
| `test` | `./gradlew test` |
| `test-e2e` | Same as `test` |
| `lint` | `./gradlew checkstyleMain checkstyleTest` |
| `format` | `./gradlew spotlessApply` |
| `format-check` | `./gradlew spotlessCheck` |
| `cpd` | `./gradlew pmdMain pmdTest` |
| `spotbugs` | `./gradlew spotbugsMain` |
| `architecture-test` | `./gradlew architectureTest` |
| `check` | `lint format-check cpd spotbugs architecture-test test` |

The example Makefile exports `GRADLE_OPTS` to redirect the build directory for all targets:

```makefile
GRADLE_OPTS := -Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-example
export GRADLE_OPTS
```

### Root `lang/java/Makefile` cascading behaviour

| Root target | Delegates to |
|---|---|
| `check` | core, sdk, example |
| `test-e2e` | core, sdk, example |
| `lint` | core, sdk, example |
| `format-check` | core, sdk, example |
| `cpd` | core, sdk, example |
| `spotbugs` | core, sdk, example |
| `architecture-test` | core, sdk, example |

Example:

```sh
# From repo root
make -C lang/java check              # runs check in core, sdk, example
make -C lang/java/core test          # runs ./gradlew test in core only
make -C lang/java/core lint          # Checkstyle — zero violations
make -C lang/java/core format-check  # Spotless — no changes needed
make -C lang/java/core cpd           # PMD CPD — zero duplicates
make -C lang/java/core spotbugs      # SpotBugs — zero bugs
make -C lang/java/core architecture-test  # Arch tests — all pass
```

---

## Tooling

| Tool | Purpose | Config |
|---|---|---|
| Gradle | Build + test runner | `build.gradle`, `gradlew` |
| JUnit 5 | Test framework | Via Gradle `test` task |
| Cucumber Java | BDD step definitions | `cucumber-java 7.15.0` |
| Cucumber JUnit Platform Engine | Cucumber → JUnit 5 bridge | `cucumber-junit-platform-engine` |
| Jackson | JSON serialisation | `jackson-databind 2.17.0` |
| AWS SDK v2 | Client library in tests | BOM `2.26.0` |
| Checkstyle 10.17.0 | Style, imports, complexity (≤10) | `lang/java/config/checkstyle/checkstyle.xml` |
| Spotless + Google Java Format 1.22.0 | Code formatting | Configured in `build.gradle` |
| PMD 7.4.0 | Static analysis + CPD copy-paste detection | `lang/java/config/pmd/pmd-ruleset.xml` |
| SpotBugs 4.8.6 | Bytecode static analysis | `lang/java/config/spotbugs/exclude.xml` |

---

## Shared Config Directory

`lang/java/config/` contains quality tool configuration shared by all three projects.
Each `build.gradle` references config files via relative path `../config/`:

```groovy
checkstyle { configFile = file('../config/checkstyle/checkstyle.xml') }
pmd { ruleSetConfig = resources.text.fromFile('../config/pmd/pmd-ruleset.xml') }
spotbugs { excludeFilter = file('../config/spotbugs/exclude.xml') }
```

Do not duplicate these files inside individual project directories.

---

## Architecture Tests Package

`lang/java/arch_tests/` is a shared Gradle library that produces `arch_tests.jar`.
It is consumed by core, sdk, and example as a `architectureTestImplementation` dependency.

### Shared test classes

| Class | What it enforces |
|---|---|
| `AaaCommentsTest` | `@Test` methods must contain `// Arrange`, `// Act`, `// Assert` |
| `NoMagicStringsTest` | Assertion calls must not use inline string literals |
| `NoSkippedTestsTest` | No `@Disabled` annotations in test sources |
| `FileNamingTest` | Test files must end in `Test.java`, `Steps.java`, etc. |
| `FileLengthTest` | `src/main/` files must be ≤500 lines |
| `NoBareExceptionsTest` | No empty catch blocks in `src/main/` |

### System properties

Each project's `architectureTest` Gradle task passes two system properties:

| Property | Value |
|---|---|
| `arch.src.root` | `${projectDir}/src/main/java` |
| `arch.tests.root` | `${projectDir}/src/test/java` |

### Delegation classes

Each project's `src/architectureTest/java/` contains one thin subclass per shared test,
which inherits all assertions from the base class in `arch_tests`. No test logic lives there.

### Building arch_tests before architecture-test

Architecture tests require `arch_tests.jar` to be built first:

```sh
cd lang/java/arch_tests && ./gradlew jar
# then run architecture tests in any project
make -C lang/java/core architecture-test
```

CI builds `arch_tests.jar` as a step before running architecture tests in each project.

---

## Test Structure

Tests follow standard Maven/Gradle layout:

- Step definition classes live in `src/test/java/io/localwebservices/lws/`
  and are named `<Service>Steps.java` (e.g., `DynamoDbSteps.java`)
- The Cucumber runner is `CucumberRunnerTest.java` (annotated with
  `@Suite`, `@IncludeEngines("cucumber")`)
- Feature files live in `src/test/resources/` (Gradle includes
  `../../specification/core` test resources in core)

---

## SDK Dependency Chain

The SDK depends on the core JAR at build time. CI builds JARs explicitly
before running downstream tests:

1. `lang/java/core`: `./gradlew jar` → produces `build/libs/lws-java-core-0.1.0.jar`
2. `lang/java/sdk`: references core JAR via `files('../core/build/libs/...')`; `./gradlew jar`
3. `lang/java/example`: references both core and sdk JARs

When running locally, build JARs in order before running tests in downstream projects.

---

## CI Job Naming and Structure

Job name format: `java-{project}-{type}`

### Jobs

| Job | Command | Depends on |
|---|---|---|
| `java-core-test` | `./gradlew test` in `lang/java/core` | — |
| `java-sdk-test` | Build core JAR, then `./gradlew test` in `lang/java/sdk` | `java-core-test` |
| `java-example-test` | Build core + sdk JARs, then `./gradlew test` in `lang/java/example` | `java-sdk-test` |
| `java-core-lint` | `make lint format-check cpd spotbugs` in `lang/java/core` | — |
| `java-core-architecture-test` | Build arch_tests JAR, then `./gradlew architectureTest` | `java-core-test` |
| `java-sdk-lint` | Build core JAR, then `make lint format-check cpd spotbugs` in `lang/java/sdk` | — |
| `java-sdk-architecture-test` | Build arch_tests + core JARs, then `./gradlew architectureTest` | `java-sdk-test` |
| `java-example-lint` | `make lint format-check cpd spotbugs` in `lang/java/example` | — |
| `java-example-architecture-test` | Build arch_tests + core + sdk JARs, then `./gradlew architectureTest` | `java-example-test` |

### Change detection gating

All jobs are gated on the `java` filter:

```
lang/java/**
```

A change to any file under `lang/java/` triggers all jobs.

---

## Feature Files Are Read-Only

Feature files in `lang/specification/` are the **canonical source of truth**
for behaviour across all language implementations. **Never edit them to work
around a limitation in a specific language's fake** — fix the fake instead.
The only permitted reason to modify a feature file is a deliberate change to
the shared specification itself.

---

## Adding a New Service

Each new service needs:

1. Handler class at `lang/java/core/src/main/java/io/localwebservices/lws/providers/<service>/Handler.java`
2. Store class at `lang/java/core/src/main/java/io/localwebservices/lws/providers/<service>/Store.java`
3. Registration in `lang/java/core/src/main/java/io/localwebservices/lws/LwsServer.java` with a port offset
4. SDK client builder in `lang/java/sdk/src/main/java/io/localwebservices/lws/LwsSession.java`
5. Step definitions at `lang/java/sdk/src/test/java/io/localwebservices/lws/<Service>Steps.java`
6. A Gherkin feature file in `lang/specification/core/informal/<service>/`
