load("@rules_shell//shell:sh_test.bzl", "sh_test")

# Java example project.
# Tests use JUnit 5 and are integration tests requiring `ldk dev` and Docker.
# Delegates to the Gradle wrapper (handles JUnit 5 discovery correctly).

sh_test(
    name = "tests",
    srcs = ["run_tests.sh"],
    data = glob(
        [
            "src/**",
            "gradle/**",
        ],
    ) + [
        "build.gradle",
        "settings.gradle",
        "gradlew",
        "gradlew.bat",
        "//core:ldk",
    ],
    tags = ["local"],
)
