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
        "@maven//:software_amazon_awssdk_apigateway",
        "@maven//:software_amazon_awssdk_cognitoidentityprovider",
        "@maven//:software_amazon_awssdk_lambda",
        "@maven//:software_amazon_awssdk_secretsmanager",
        "@maven//:software_amazon_awssdk_sfn",
        "@maven//:software_amazon_awssdk_sns",
        "@maven//:software_amazon_awssdk_sqs",
        "@maven//:software_amazon_awssdk_ssm",
        "@maven//:software_amazon_awssdk_rds",
        "@maven//:software_amazon_awssdk_docdb",
        "@maven//:software_amazon_awssdk_neptune",
        "@maven//:software_amazon_awssdk_elasticache",
        "@maven//:software_amazon_awssdk_memorydb",
        "@maven//:software_amazon_awssdk_glacier",
        "@maven//:software_amazon_awssdk_elasticsearch",
        "@maven//:software_amazon_awssdk_opensearch",
        "@maven//:software_amazon_awssdk_s3tables",
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
