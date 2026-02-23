load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@aspect_rules_ts//ts:defs.bzl", "ts_project")
load("@npm_typescript_sdk//:defs.bzl", "npm_link_all_packages")

npm_link_all_packages(name = "node_modules")

ts_project(
    name = "lws_typescript_sdk",
    srcs = glob(["src/**/*.ts"]),
    tsconfig = "tsconfig.json",
    declaration = True,
    deps = [":node_modules"],
    visibility = ["//visibility:public"],
)

# Tests use jest via npm script: bazel run :test
js_library(
    name = "test_lib",
    srcs = glob(["tests/**/*.ts"]),
    deps = [
        ":lws_typescript_sdk",
        ":node_modules",
    ],
)
