load("@rules_go//go:def.bzl", "go_test")

go_test(
    name = "tests",
    srcs = glob(["*_test.go"]),
    importpath = "github.com/local-web-services/local-web-services-sdk-go-example-project",
    deps = ["//lang/go/sdk:lws"],
)
