load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@npm_typescript_sdk//:defs.bzl", "npm_link_all_packages")

npm_link_all_packages(name = "node_modules")

js_library(
    name = "example",
    srcs = glob(["src/**/*.ts", "tests/**/*.ts"]),
    deps = [
        "//lang/typescript/sdk:lws_typescript_sdk",
        ":node_modules",
    ],
)
