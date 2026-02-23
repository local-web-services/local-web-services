load("@rules_python//python:defs.bzl", "py_test")
load("@pip_python_sdk//:requirements.bzl", "requirement")

py_test(
    name = "tests",
    srcs = glob(["**/*.py"]),
    main = "pytest_runner.py",
    imports = ["../src"],
    data = ["//core:ldk"],
    deps = [
        "//lang/python/sdk:lws_testing",
        requirement("pytest"),
        requirement("boto3"),
    ],
)
