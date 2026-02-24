load("@pip_python_sdk//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_test")

py_test(
    name = "tests",
    srcs = glob(["**/*.py"]),
    data = ["//core:ldk"],
    imports = ["../src"],
    main = "pytest_runner.py",
    deps = [
        "//lang/python/sdk:lws_testing",
        requirement("pytest"),
        requirement("boto3"),
    ],
)
