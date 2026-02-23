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

# Tests live in //lang/python/sdk/tests:tests to avoid output-path prefix conflicts.
