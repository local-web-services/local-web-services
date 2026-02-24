load("@pip_core//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary", "py_library", "py_test")

py_library(
    name = "lws",
    srcs = glob(["src/**/*.py"]),
    imports = ["src"],
    visibility = ["//visibility:public"],
    deps = [
        requirement("fastapi"),
        requirement("uvicorn"),
        requirement("typer"),
        requirement("watchdog"),
        requirement("aiosqlite"),
        requirement("croniter"),
        requirement("rich"),
        requirement("python-multipart"),
        requirement("pyjwt"),
        requirement("httpx"),
        requirement("docker"),
        requirement("pyyaml"),
    ],
)

py_binary(
    name = "ldk",
    srcs = ["src/lws/cli/ldk.py"],
    imports = ["src"],
    main = "src/lws/cli/ldk.py",
    visibility = ["//visibility:public"],
    deps = [":lws"],
)

py_binary(
    name = "lws_cli",
    srcs = ["src/lws/cli/lws.py"],
    imports = ["src"],
    main = "src/lws/cli/lws.py",
    visibility = ["//visibility:public"],
    deps = [":lws"],
)

# Tests live in //core/tests:tests to avoid output-path prefix conflicts.
