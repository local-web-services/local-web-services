load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@npm_javascript_sdk//:defs.bzl", "npm_link_all_packages")

npm_link_all_packages(name = "node_modules")

js_library(
    name = "example",
    srcs = glob(["src/**/*.js", "tests/**/*.js"]),
    deps = [
        "//lang/javascript/sdk:lws_javascript_sdk",
        ":node_modules",
    ],
)
