load("@rules_jvm_external//:defs.bzl", "java_export")

java_library(
    name = "lws_java_sdk",
    srcs = glob(["src/main/java/**/*.java"]),
    deps = [
        "@maven//:software_amazon_awssdk_dynamodb",
        "@maven//:software_amazon_awssdk_sqs",
        "@maven//:software_amazon_awssdk_s3",
        "@maven//:software_amazon_awssdk_sns",
        "@maven//:software_amazon_awssdk_sfn",
        "@maven//:software_amazon_awssdk_ssm",
        "@maven//:software_amazon_awssdk_secretsmanager",
    ],
    visibility = ["//visibility:public"],
)

java_test(
    name = "tests",
    srcs = glob(["src/test/java/**/*.java"]),
    test_class = "io.localwebservices.lws.AllTests",
    deps = [
        ":lws_java_sdk",
        "@maven//:org_junit_jupiter_junit_jupiter_api",
        "@maven//:org_junit_jupiter_junit_jupiter_engine",
    ],
)
