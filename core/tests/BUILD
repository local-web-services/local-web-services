load("@rules_python//python:defs.bzl", "py_test")
load("@pip_core//:requirements.bzl", "requirement")

py_test(
    name = "tests",
    srcs = glob(["**/*.py"]),
    main = "pytest_runner.py",
    imports = ["../src"],
    deps = [
        "//core:lws",
        requirement("pytest"),
        requirement("pytest-asyncio"),
        requirement("httpx"),
    ],
)
