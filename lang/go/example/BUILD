load("@rules_go//go:def.bzl", "go_test")

# Example project: order processor backed by Step Functions.
# Both source files share package main so they are compiled together for tests.
go_test(
    name = "tests",
    srcs = [
        "order_processor.go",
        "order_processor_test.go",
    ],
    importpath = "github.com/local-web-services/local-web-services-sdk-go-example-project",
    deps = [
        "//lang/go/sdk/lws:lws",
        "@com_github_aws_aws_sdk_go_v2_service_sfn//:sfn",
    ],
    tags = ["local"],
)
