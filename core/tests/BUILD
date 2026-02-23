load("@pip_core//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_test")

py_test(
    name = "tests",
    srcs = glob(["**/*.py"]),
    imports = ["../src"],
    main = "pytest_runner.py",
    deps = [
        "//core:lws",
        requirement("pytest"),
        requirement("pytest-asyncio"),
        requirement("httpx"),
    ],
)
