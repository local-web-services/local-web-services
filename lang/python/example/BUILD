load("@rules_python//python:defs.bzl", "py_test")
load("@pip_python_sdk//:requirements.bzl", "requirement")

py_test(
    name = "tests",
    srcs = glob(["tests/**/*.py"]),
    imports = ["src"],
    data = [
        "//core:ldk",
        "//lang/python/sdk:lws_testing",
    ],
    deps = [
        "//lang/python/sdk:lws_testing",
        requirement("pytest"),
        requirement("boto3"),
    ],
)
