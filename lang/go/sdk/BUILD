load("@rules_go//go:def.bzl", "go_library", "go_test")

# Run `bazel run //:gazelle` to regenerate Go BUILD files from go.mod
go_library(
    name = "lws",
    srcs = glob(["lws/**/*.go"]),
    importpath = "github.com/local-web-services/local-web-services-go-sdk/lws",
    visibility = ["//visibility:public"],
)
