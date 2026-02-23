load("@rules_shell//shell:sh_test.bzl", "sh_test")

# JavaScript SDK
# Tests are integration tests that require `ldk dev` (a subprocess) and Docker.
# Full Bazel JS compilation (aspect_rules_js) needs pnpm-lock.yaml; this project
# uses package-lock.json, so we use sh_test and delegate to npm instead.

sh_test(
    name = "tests",
    srcs = ["run_tests.sh"],
    data = glob(
        [
            "src/**",
            "tests/**",
        ],
    ) + [
        "package.json",
        "package-lock.json",
        "//core:ldk",
    ],
    tags = ["local"],
)
