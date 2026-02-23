load("@rules_go//go:def.bzl", "go_library", "go_test")

# Example project: order processor backed by Step Functions.
# Both source files share package main so they are compiled together for tests.
go_test(
    name = "tests",
    srcs = [
        "order_processor.go",
        "order_processor_test.go",
    ],
    importpath = "github.com/local-web-services/local-web-services-sdk-go-example-project",
    tags = ["local"],
    deps = [
        "//lang/go/sdk/lws",
        "@com_github_aws_aws_sdk_go_v2_service_sfn//:sfn",
    ],
)

go_library(
    name = "local-web-services-sdk-go-example-project_lib",
    srcs = ["order_processor.go"],
    importpath = "github.com/local-web-services/local-web-services-sdk-go-example-project",
    visibility = ["//visibility:public"],
    deps = ["@com_github_aws_aws_sdk_go_v2_service_sfn//:sfn"],
)

go_test(
    name = "local-web-services-sdk-go-example-project_test",
    srcs = ["order_processor_test.go"],
    embed = [":local-web-services-sdk-go-example-project_lib"],
    deps = [
        "//lang/go/sdk/lws",
        "@com_github_aws_aws_sdk_go_v2_service_sfn//:sfn",
    ],
)
