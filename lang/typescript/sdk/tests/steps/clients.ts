/** Step definitions: client_creation */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// Stored across steps
let lastClient: unknown = null;
let lastService: string = "";

When("I request a client for {string}", function (this: SdkWorld, service: string) {
  assert.ok(this.session, "No session running");
  lastClient = this.session!.client(service);
  lastService = service;
});

Then("a configured client is returned", function (this: SdkWorld) {
  assert.ok(lastClient !== null && lastClient !== undefined, "Expected a non-null client");
});

Then(
  "the client can successfully call the {word} service",
  async function (this: SdkWorld, service: string) {
    assert.ok(lastClient, "No client available");

    // Make a simple list call for each service
    switch (service.toLowerCase()) {
      case "dynamodb": {
        const { ListTablesCommand } = require("@aws-sdk/client-dynamodb");
        const result = await (lastClient as any).send(new ListTablesCommand({}));
        assert.ok(Array.isArray(result.TableNames), "Expected TableNames array");
        break;
      }
      case "sqs": {
        const { ListQueuesCommand } = require("@aws-sdk/client-sqs");
        const result = await (lastClient as any).send(new ListQueuesCommand({}));
        assert.ok(result !== null && result !== undefined, "Expected SQS result");
        break;
      }
      case "s3": {
        const { ListBucketsCommand } = require("@aws-sdk/client-s3");
        const result = await (lastClient as any).send(new ListBucketsCommand({}));
        assert.ok(Array.isArray(result.Buckets), "Expected Buckets array");
        break;
      }
      case "sns": {
        const { ListTopicsCommand } = require("@aws-sdk/client-sns");
        const result = await (lastClient as any).send(new ListTopicsCommand({}));
        assert.ok(Array.isArray(result.Topics), "Expected Topics array");
        break;
      }
      case "stepfunctions": {
        const { ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
        const result = await (lastClient as any).send(new ListStateMachinesCommand({}));
        assert.ok(Array.isArray(result.stateMachines), "Expected stateMachines array");
        break;
      }
      case "ssm": {
        const { DescribeParametersCommand } = require("@aws-sdk/client-ssm");
        const result = await (lastClient as any).send(new DescribeParametersCommand({}));
        assert.ok(result !== null && result !== undefined, "Expected SSM result");
        break;
      }
      case "secretsmanager": {
        const { ListSecretsCommand } = require("@aws-sdk/client-secrets-manager");
        const result = await (lastClient as any).send(new ListSecretsCommand({}));
        assert.ok(result !== null && result !== undefined, "Expected SecretsManager result");
        break;
      }
      default:
        throw new Error(`No test call implemented for service "${service}"`);
    }
  },
);
