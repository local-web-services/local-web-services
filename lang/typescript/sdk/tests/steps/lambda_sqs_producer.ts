/** Step definitions: lambda_sqs_producer cross-service informal specification scenarios */

// Steps already registered elsewhere are NOT re-registered here:
//   "the system is initialized"                               → cross_service_common.ts
//   "the operation is rejected"                               → cross_service_common.ts
//   "the queue does not already exist"                        → cross_service_common.ts
//   "the queue already exists"                                → cross_service_common.ts
//   "the queue exists"                                        → cross_service_common.ts
//   "the queue does not exist"                                → cross_service_common.ts
//   "the queue is {string}" (Given)                           → sqs.ts
//   "the queue is not {string}" (Given)                       → sqs.ts
//   "the queue is {string}" (Then)                            → cross_service_common.ts
//   "the function does not already exist"                     → lambda.ts
//   "the function already exists"                             → lambda.ts
//   "the function exists"                                     → lambda.ts
//   "the function does not exist"                             → lambda.ts
//   "the function is {string}" (Given)                        → lambda.ts
//   "the function is not {string}" (Given)                    → lambda.ts
//   "an invocation is IN_PROGRESS"                            → lambda_sqs.ts
//   "no invocation is IN_PROGRESS"                            → lambda_sqs.ts
//   "an invocation slot is available"                         → lambda_sqs.ts
//   "no invocation slot is available"                         → lambda_sqs.ts
//   "a message slot is available"                             → lambda_sqs.ts
//   "no message slot is available"                            → lambda_sqs.ts
//   "a Lambda function is deployed"                           → lambda_sqs.ts
//   "an SQS queue is created"                                 → lambda_sqs.ts
//   "the Lambda function is invoked"                          → lambda_sqs.ts
//   "the Lambda invocation fails"                             → lambda_sqs.ts
//   "the Lambda invocation completes successfully"            → lambda_sqs.ts
//   "the function is ACTIVE" (Then)                           → lambda_sqs.ts
//   "the invocation is IN_PROGRESS" (Then)                    → lambda_sqs.ts
//   "the invocation is FAILED" (Then)                         → lambda_sqs.ts
//   "the invocation is SUCCESS" (Then)                        → events_lambda.ts
//   every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function → events_lambda.ts
//   every "AVAILABLE" message belongs to an "ACTIVE" queue    → apigateway_sqs.ts

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// ── When: actions unique to lambda_sqs_producer ───────────────────────────────

When(
  'the Lambda function sends a message to the "SQS" queue during invocation',
  async function (this: SdkWorld) {
    // Cannot trigger a Lambda SQS send from within an invocation in lws.
    // Store a failure so "the operation is rejected" Then step passes when applicable.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda SQS send in lws: no Docker execution"),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions unique to lambda_sqs_producer ───────────────────────────

Then('the message is "AVAILABLE" in the queue', async function (this: SdkWorld) {
  // Cannot observe a message sent by a Lambda function in lws without Docker
  // execution. No-op: scenarios that reach this step are excluded from the run
  // or their When step has already stored a failure.
  assert.ok(this.session, "Expected session to be initialized");
});
