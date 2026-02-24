load("@rules_go//go:def.bzl", "go_library", "go_test")

go_library(
    name = "lws",
    srcs = [
        "chaos.go",
        "hcl.go",
        "logs.go",
        "mock.go",
        "session.go",
        "spec.go",
    ],
    importpath = "github.com/local-web-services/local-web-services-go-sdk/lws",
    visibility = ["//visibility:public"],
    deps = [
        "@com_github_aws_aws_sdk_go_v2//aws",
        "@com_github_aws_aws_sdk_go_v2_config//:config",
        "@com_github_aws_aws_sdk_go_v2_credentials//:credentials",
        "@com_github_aws_aws_sdk_go_v2_service_dynamodb//:dynamodb",
        "@com_github_aws_aws_sdk_go_v2_service_dynamodb//types",
        "@com_github_aws_aws_sdk_go_v2_service_s3//:s3",
        "@com_github_aws_aws_sdk_go_v2_service_secretsmanager//:secretsmanager",
        "@com_github_aws_aws_sdk_go_v2_service_sfn//:sfn",
        "@com_github_aws_aws_sdk_go_v2_service_sns//:sns",
        "@com_github_aws_aws_sdk_go_v2_service_sqs//:sqs",
        "@com_github_aws_aws_sdk_go_v2_service_ssm//:ssm",
        "@com_github_aws_aws_sdk_go_v2_service_ssm//types",
        "@com_github_gorilla_websocket//:websocket",
    ],
)

# Unit tests only (no external deps, no Docker/ldk required).
go_test(
    name = "lws_test",
    srcs = ["session_test.go"],
    embed = [":lws"],
)
