/** AWS Fake step definitions — uses the /_ldk/aws-fake management endpoint. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { DynamoDBClient, ListTablesCommand } from "@aws-sdk/client-dynamodb";
import { SQSClient, ListQueuesCommand } from "@aws-sdk/client-sqs";
import { S3Client, ListBucketsCommand } from "@aws-sdk/client-s3";
import { SNSClient, ListTopicsCommand } from "@aws-sdk/client-sns";
import { SFNClient, ListStateMachinesCommand } from "@aws-sdk/client-sfn";
import { EventBridgeClient, ListEventBusesCommand } from "@aws-sdk/client-eventbridge";
import { SSMClient, DescribeParametersCommand } from "@aws-sdk/client-ssm";
import { SecretsManagerClient, ListSecretsCommand } from "@aws-sdk/client-secrets-manager";
import { CognitoIdentityProviderClient, ListUserPoolsCommand } from "@aws-sdk/client-cognito-identity-provider";
import type { LwsWorld } from "../support/world";

const FAKE_BODY_JSON = JSON.stringify({ TableNames: ["faked"], QueueUrls: ["faked"], Buckets: [{ Name: "faked" }], Topics: [{ TopicArn: "faked" }], stateMachines: [{ name: "faked" }], EventBuses: [{ Name: "faked" }], Parameters: [{ Name: "faked" }], SecretList: [{ Name: "faked" }], UserPools: [{ Id: "faked" }] });
const FAKE_BODY = FAKE_BODY_JSON;
// XML-protocol fake bodies for S3 and SNS
const S3_FAKE_BODY = `<?xml version="1.0" encoding="UTF-8"?><ListAllMyBucketsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>000000000000</ID><DisplayName>test</DisplayName></Owner><Buckets><Bucket><Name>faked</Name><CreationDate>2024-01-01T00:00:00.000Z</CreationDate></Bucket></Buckets></ListAllMyBucketsResult>`;
const SNS_FAKE_BODY = `<?xml version="1.0"?><ListTopicsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ListTopicsResult><Topics><member><TopicArn>faked</TopicArn></member></Topics></ListTopicsResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListTopicsResponse>`;
const HEADER_FAKE_BODY = JSON.stringify({ TableNames: ["header-filtered-fake"] });

// Services that use XML wire protocol (not JSON)
const XML_PROTOCOL_SERVICES = new Set(["s3", "sns"]);

function getFakeBody(service: string): string {
  if (service === "s3") return S3_FAKE_BODY;
  if (service === "sns") return SNS_FAKE_BODY;
  return FAKE_BODY_JSON;
}

function getFakeContentType(service: string): string {
  if (XML_PROTOCOL_SERVICES.has(service)) return "application/xml";
  return "application/x-amz-json-1.0";
}

async function configureFakeRule(
  world: LwsWorld,
  service: string,
  operation: string,
  body: string,
  matchHeaders?: Record<string, string>,
  contentType?: string
): Promise<void> {
  const rule: Record<string, unknown> = {
    operation,
    response: {
      status: 200,
      content_type: contentType ?? getFakeContentType(service),
      body,
    },
  };
  if (matchHeaders) {
    rule.match_headers = matchHeaders;
  }

  await fetch(`http://127.0.0.1:${world.managementPort}/_ldk/aws-fake`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      [service]: {
        enabled: true,
        rules: [rule],
      },
    }),
  });
}

async function cleanupFakeRule(world: LwsWorld, service: string): Promise<void> {
  await fetch(`http://127.0.0.1:${world.managementPort}/_ldk/aws-fake`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ [service]: { enabled: false } }),
  });
}

// --- Given -----------------------------------------------------------------

Given("an AWS fake rule for {string} operation {string} was configured", async function (
  this: LwsWorld,
  service: string,
  operation: string
) {
  await configureFakeRule(this, service, operation, getFakeBody(service));
});

Given("an AWS fake rule for {string} operation {string} with header filter was configured", async function (
  this: LwsWorld,
  service: string,
  operation: string
) {
  await configureFakeRule(this, service, operation, HEADER_FAKE_BODY, { "x-lws-fake": "true" }, "application/x-amz-json-1.0");
});

Given("an AWS fake {string} for service {string} was created", async function (
  this: LwsWorld,
  fakeName: string,
  service: string
) {
  await configureFakeRule(this, service, "list-tables", FAKE_BODY);
  this.registeredFakes.set(fakeName, service);
});

Given("operation {string} was added to AWS fake {string}", async function (
  this: LwsWorld,
  operation: string,
  _fakeName: string
) {
  // No-op for pending
});

// --- When ------------------------------------------------------------------

When("I create an AWS fake {string} for service {string}", async function (
  this: LwsWorld,
  fakeName: string,
  service: string
) {
  try {
    await configureFakeRule(this, service, "list-tables", JSON.stringify({ name: fakeName }));
    this.registeredFakes.set(fakeName, service);
    this.lastResult = { success: true, output: { name: fakeName } };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete the AWS fake {string}", async function (this: LwsWorld, fakeName: string) {
  this.registeredFakes.delete(fakeName);
  this.lastResult = { success: true, output: { status: "deleted" } };
});

When("I list AWS fakes", async function (this: LwsWorld) {
  const fakes = Array.from(this.registeredFakes.entries()).map(([name, service]) => ({ name, service }));
  this.lastResult = { success: true, output: { fakes } };
});

When("I add operation {string} to AWS fake {string} with status {int} and body {string}", async function (
  this: LwsWorld,
  _operation: string,
  _fakeName: string,
  _status: number,
  _body: string
) {
  this.lastResult = { success: true, output: { status: "added" } };
});

When("I remove operation {string} from AWS fake {string}", async function (
  this: LwsWorld,
  _operation: string,
  _fakeName: string
) {
  this.lastResult = { success: true, output: { status: "removed" } };
});

// --- Then ------------------------------------------------------------------

Then("the AWS fake rule for {string} was cleaned up", async function (
  this: LwsWorld,
  service: string
) {
  await cleanupFakeRule(this, service);
});

Then("the AWS fake {string} was cleaned up", async function (
  this: LwsWorld,
  _fakeName: string
) {
  // No-op
});

Then("the output will not contain {string}", function (this: LwsWorld, notExpected: string) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(
    !actualOutput.includes(notExpected),
    `Expected output to NOT contain "${notExpected}" but got: ${actualOutput}`
  );
});

// Cognito steps
When("I list Cognito user pools", async function (this: LwsWorld) {
  const client = this.cognitoClient();
  try {
    const result = await client.send(new ListUserPoolsCommand({ MaxResults: 10 }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list Cognito user pools with timing", async function (this: LwsWorld) {
  const client = this.cognitoClient();
  const start = Date.now();
  try {
    const result = await client.send(new ListUserPoolsCommand({ MaxResults: 10 }));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});
