load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@npm_javascript_sdk//:defs.bzl", "npm_link_all_packages")

npm_link_all_packages(name = "node_modules")

js_library(
    name = "lws_javascript_sdk",
    srcs = glob(["src/**/*.js"]),
    deps = [":node_modules"],
    visibility = ["//visibility:public"],
)

js_library(
    name = "test_lib",
    srcs = glob(["tests/**/*.js"]),
    deps = [
        ":lws_javascript_sdk",
        ":node_modules",
    ],
)
