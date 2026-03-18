# Java Language Implementation — Conventions

This document is the authoritative reference for the Java implementation's
testing strategy, Makefile targets, CI structure, and shared tooling. Read it
before writing or modifying anything under `lang/java/`.

---

## Directory Layout

```
lang/java/
├── core/            AWS emulator server — com.sun.net.httpserver handlers
│   ├── src/main/java/io/localwebservices/lws/
│   ├── src/test/java/io/localwebservices/lws/
│   ├── src/test/resources/         Feature files + Cucumber config
│   ├── build.gradle
│   ├── gradlew
│   └── Makefile
├── sdk/             Testing SDK for user projects
│   ├── src/main/java/io/localwebservices/lws/
│   ├── src/test/java/io/localwebservices/lws/
│   ├── src/test/resources/
│   ├── build.gradle
│   └── Makefile
├── example/         Reference project demonstrating SDK usage
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

All test types are run together via `./gradlew test`. There is no separate
unit vs BDD split — JUnit 5 runs Cucumber via the Cucumber JUnit Platform Engine.

Feature files (`.feature`) live in `src/test/resources/` within each project,
referencing the canonical specs from `lang/specification/core/informal/<service>/`.

---

## Makefile Targets

### Standard targets — must exist in `core/`, `sdk/`, and `example/`

| Target | Description |
|---|---|
| `test` | `./gradlew test` |
| `test-e2e` | Same as `test` |
| `check` | `test` |

The example target sets `GRADLE_OPTS` to redirect the build directory:

```sh
GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-example" ./gradlew test
```

### Root `lang/java/Makefile` cascading behaviour

| Root target | Delegates to |
|---|---|
| `check` | core, sdk, example |
| `test-e2e` | core, sdk, example |

Example:

```sh
# From repo root
make -C lang/java check              # runs check in core, sdk, example
make -C lang/java/core test          # runs ./gradlew test in core only
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

Job name format: `java-{project}-test`

### Jobs

| Job | Command | Needs Docker | Depends on |
|---|---|---|---|
| `java-core-test` | `GRADLE_OPTS=... ./gradlew test` in `lang/java/core` | No | — |
| `java-sdk-test` | Build core JAR, then `./gradlew test` in `lang/java/sdk` | No | `java-core-test` |
| `java-example-test` | Build core + sdk JARs, then `./gradlew test` in `lang/java/example` | No | `java-sdk-test` |

### Change detection gating

All three jobs are gated on the `java` filter:

```
lang/java/**
```

A change to any file under `lang/java/` triggers all three jobs.

---

## Adding a New Service

Each new service needs:

1. Handler class at `lang/java/core/src/main/java/io/localwebservices/lws/providers/<service>/Handler.java`
2. Store class at `lang/java/core/src/main/java/io/localwebservices/lws/providers/<service>/Store.java`
3. Registration in `lang/java/core/src/main/java/io/localwebservices/lws/LwsServer.java` with a port offset
4. SDK client builder in `lang/java/sdk/src/main/java/io/localwebservices/lws/LwsSession.java`
5. Step definitions at `lang/java/sdk/src/test/java/io/localwebservices/lws/<Service>Steps.java`
6. A Gherkin feature file in `lang/specification/core/informal/<service>/`
