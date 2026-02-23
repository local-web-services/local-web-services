load("@rules_python//python:defs.bzl", "py_binary", "py_library", "py_test")
load("@pip_core//:requirements.bzl", "requirement")

py_library(
    name = "lws",
    srcs = glob(["src/**/*.py"]),
    imports = ["src"],
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
    visibility = ["//visibility:public"],
)

py_binary(
    name = "ldk",
    srcs = ["src/lws/cli/ldk.py"],
    main = "src/lws/cli/ldk.py",
    imports = ["src"],
    deps = [":lws"],
    visibility = ["//visibility:public"],
)

py_binary(
    name = "lws_cli",
    srcs = ["src/lws/cli/lws.py"],
    main = "src/lws/cli/lws.py",
    imports = ["src"],
    deps = [":lws"],
    visibility = ["//visibility:public"],
)

# Tests live in //core/tests:tests to avoid output-path prefix conflicts.
