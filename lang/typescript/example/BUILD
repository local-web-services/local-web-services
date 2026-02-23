load("@rules_shell//shell:sh_test.bzl", "sh_test")

# TypeScript example project.
# Tests are integration tests that require `ldk dev` (a subprocess) and Docker.

sh_test(
    name = "tests",
    srcs = ["run_tests.sh"],
    data = glob(
        [
            "src/**",
            "tests/**",
            "tsconfig*.json",
        ],
    ) + [
        "package.json",
        "package-lock.json",
        "//core:ldk",
    ],
    tags = ["local"],
)
