load("@pip_python_sdk//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_library", "py_test")

py_library(
    name = "lws_testing",
    srcs = glob(["src/**/*.py"]),
    imports = ["src"],
    visibility = ["//visibility:public"],
    deps = [
        "//core:lws",
        requirement("httpx"),
        requirement("botocore"),
        requirement("pyyaml"),
    ],
)

# Tests live in //lang/python/sdk/tests:tests to avoid output-path prefix conflicts.
