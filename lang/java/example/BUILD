java_test(
    name = "tests",
    srcs = glob(["src/test/java/**/*.java"]),
    test_class = "com.example.AllTests",
    deps = [
        "//lang/java/sdk:lws_java_sdk",
        "@maven//:org_junit_jupiter_junit_jupiter_api",
        "@maven//:org_junit_jupiter_junit_jupiter_engine",
    ],
)
