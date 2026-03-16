module.exports = {
  default: {
    require: ["tests/support/world.ts", "tests/steps/**/*.ts"],
    requireModule: ["ts-node/register"],
    paths: [
      "../../../lang/specification/sdk/features/chaos_injection.feature",
      "../../../lang/specification/sdk/features/client_creation.feature",
      "../../../lang/specification/sdk/features/dynamodb_helper.feature",
      "../../../lang/specification/sdk/features/fake_responses.feature",
      "../../../lang/specification/sdk/features/iam_enforce.feature",
      "../../../lang/specification/sdk/features/log_capture.feature",
      "../../../lang/specification/sdk/features/resource_specification.feature",
      "../../../lang/specification/sdk/features/session_lifecycle.feature",
      "../../../lang/specification/sdk/features/session_reset.feature",
      "../../../lang/specification/sdk/features/sqs_helper.feature",
    ],
    format: ["progress"],
    timeout: 60000,
  },
};
