load("@rules_java//java:defs.bzl", "java_library")
load("@rules_shell//shell:sh_test.bzl", "sh_test")

# Java SDK library — built by Bazel for dependency checking.
java_library(
    name = "lws_java_sdk",
    srcs = glob(["src/main/java/**/*.java"]),
    visibility = ["//visibility:public"],
    deps = [
        "@maven//:software_amazon_awssdk_auth",
        "@maven//:software_amazon_awssdk_dynamodb",
        "@maven//:software_amazon_awssdk_regions",
        "@maven//:software_amazon_awssdk_s3",
        "@maven//:software_amazon_awssdk_secretsmanager",
        "@maven//:software_amazon_awssdk_sfn",
        "@maven//:software_amazon_awssdk_sns",
        "@maven//:software_amazon_awssdk_sqs",
        "@maven//:software_amazon_awssdk_ssm",
    ],
)

# Tests use JUnit 5 (Jupiter) and are integration tests that require `ldk dev`.
# Delegate to the Gradle wrapper which handles JUnit 5 discovery correctly.
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
        "gradlew",
        "gradlew.bat",
        "settings.gradle",
        "//core:ldk",
    ],
    tags = ["local"],
)
