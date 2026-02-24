load("@rules_shell//shell:sh_test.bzl", "sh_test")

# JavaScript example project.
# Tests are integration tests that require `ldk dev` (a subprocess) and Docker.

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
