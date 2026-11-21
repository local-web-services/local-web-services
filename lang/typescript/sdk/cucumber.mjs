/** @type {import('@cucumber/cucumber').IConfiguration} */
export default {
  loader: ["ts-node/esm"],
  paths: ["tests/e2e/sqs/features/**/*.feature"],
  import: [
    "tests/e2e/sqs/support/*.ts",
    "tests/e2e/sqs/step_definitions/*.ts",
  ],
  format: ["progress-bar", "json:test-results/cucumber-report.json"],
  tags: "not @lifecycle and not @capacity and not @sequence",
  timeout: 30000,
};
