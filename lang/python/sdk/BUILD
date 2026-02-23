load("@rules_python//python:defs.bzl", "py_library", "py_test")
load("@pip_python_sdk//:requirements.bzl", "requirement")

py_library(
    name = "lws_testing",
    srcs = glob(["src/**/*.py"]),
    imports = ["src"],
    deps = [
        "//core:lws",
        requirement("httpx"),
        requirement("botocore"),
        requirement("pyyaml"),
    ],
    visibility = ["//visibility:public"],
)

py_test(
    name = "tests",
    srcs = glob(["tests/**/*.py"]),
    imports = ["src"],
    data = ["//core:ldk"],
    deps = [
        ":lws_testing",
        requirement("pytest"),
        requirement("boto3"),
    ],
)
