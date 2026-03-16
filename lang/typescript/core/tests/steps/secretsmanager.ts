/** Secrets Manager step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateSecretCommand,
  DeleteSecretCommand,
  DescribeSecretCommand,
  GetSecretValueCommand,
  ListSecretsCommand,
  PutSecretValueCommand,
  RestoreSecretCommand,
  TagResourceCommand,
  UntagResourceCommand,
  GetResourcePolicyCommand,
  ListSecretVersionIdsCommand,
  UpdateSecretCommand,
} from "@aws-sdk/client-secrets-manager";
import type { LwsWorld } from "../support/world";

async function createSecret(world: LwsWorld, name: string, value: string): Promise<void> {
  const client = world.secretsManagerClient();
  await client.send(new CreateSecretCommand({ Name: name, SecretString: value }));
}

// --- Given -----------------------------------------------------------------

Given("a secret {string} was created with value {string}", async function (
  this: LwsWorld,
  name: string,
  value: string
) {
  await createSecret(this, name, value);
});

Given("the secret {string} was deleted", async function (this: LwsWorld, name: string) {
  const client = this.secretsManagerClient();
  await client.send(new DeleteSecretCommand({ SecretId: name }));
});

Given("tags [\\{{string}: {string}, {string}: {string}}] were added to secret {string}", async function (
  this: LwsWorld,
  _k1: string,
  _v1: string,
  _k2: string,
  _v2: string,
  name: string
) {
  const client = this.secretsManagerClient();
  await client.send(
    new TagResourceCommand({ SecretId: name, Tags: [{ Key: "env", Value: "test" }] })
  );
});

Given("tags [{string}] were added to secret {string}", async function (
  this: LwsWorld,
  _tagsStr: string,
  name: string
) {
  const client = this.secretsManagerClient();
  await client.send(
    new TagResourceCommand({ SecretId: name, Tags: [{ Key: "env", Value: "test" }] })
  );
});

// --- When ------------------------------------------------------------------

When("I create secret {string} with value {string}", async function (
  this: LwsWorld,
  name: string,
  value: string
) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new CreateSecretCommand({ Name: name, SecretString: value })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I create secret {string} with value {string} and description {string}", async function (
  this: LwsWorld,
  name: string,
  value: string,
  description: string
) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new CreateSecretCommand({ Name: name, SecretString: value, Description: description })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete secret {string} with force delete without recovery", async function (
  this: LwsWorld,
  name: string
) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new DeleteSecretCommand({ SecretId: name, ForceDeleteWithoutRecovery: true })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I describe secret {string}", async function (this: LwsWorld, name: string) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new DescribeSecretCommand({ SecretId: name }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get secret value for {string}", async function (this: LwsWorld, name: string) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new GetSecretValueCommand({ SecretId: name }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list secrets", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new ListSecretsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I put secret value {string} for {string}", async function (
  this: LwsWorld,
  value: string,
  name: string
) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new PutSecretValueCommand({ SecretId: name, SecretString: value })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I restore secret {string}", async function (this: LwsWorld, name: string) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new RestoreSecretCommand({ SecretId: name }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I tag secret {string} with tags [\\{{string}: {string}, {string}: {string}}]", async function (
  this: LwsWorld,
  name: string,
  _k1: string,
  _v1: string,
  _k2: string,
  _v2: string
) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new TagResourceCommand({ SecretId: name, Tags: [{ Key: "env", Value: "test" }] })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I tag secret {string} with tags [{string}]", async function (
  this: LwsWorld,
  name: string,
  _tagsStr: string
) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new TagResourceCommand({ SecretId: name, Tags: [{ Key: "env", Value: "test" }] })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I untag secret {string} with tag keys [{string}]", async function (
  this: LwsWorld,
  name: string,
  _tagKeysStr: string
) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new UntagResourceCommand({ SecretId: name, TagKeys: ["env"] })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I untag secret {string} with tag keys {string}", async function (
  this: LwsWorld,
  name: string,
  tagKeysJson: string
) {
  const client = this.secretsManagerClient();
  const tagKeys = JSON.parse(tagKeysJson) as string[];
  try {
    const result = await client.send(
      new UntagResourceCommand({ SecretId: name, TagKeys: tagKeys })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get resource policy for {string}", async function (this: LwsWorld, name: string) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new GetResourcePolicyCommand({ SecretId: name }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list secret version IDs for {string}", async function (this: LwsWorld, name: string) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new ListSecretVersionIdsCommand({ SecretId: name }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I update secret {string} with value {string}", async function (
  this: LwsWorld,
  name: string,
  value: string
) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new UpdateSecretCommand({ SecretId: name, SecretString: value })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Timed variant
When("I list Secrets Manager secrets with timing", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  const start = Date.now();
  try {
    const result = await client.send(new ListSecretsCommand({}));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});

When("I list Secrets Manager secrets", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new ListSecretsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then("the output will contain secret name {string}", function (this: LwsWorld, name: string) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(actualOutput.includes(name), `Expected output to contain secret name "${name}"`);
});

Then("the output will contain secret value {string}", function (
  this: LwsWorld,
  expectedValue: string
) {
  const output = this.lastResult.output as { SecretString?: string };
  assert.strictEqual(output?.SecretString, expectedValue);
});

Then("secret {string} will have value {string}", async function (
  this: LwsWorld,
  name: string,
  expectedValue: string
) {
  const client = this.secretsManagerClient();
  const result = await client.send(new GetSecretValueCommand({ SecretId: name }));
  assert.strictEqual(result.SecretString, expectedValue);
});

Then("secret {string} will appear in describe-secret", async function (
  this: LwsWorld,
  name: string
) {
  const client = this.secretsManagerClient();
  const result = await client.send(new DescribeSecretCommand({ SecretId: name }));
  assert.ok(result.Name, "Expected secret to be described");
});

Then("secret {string} will not appear in list-secrets", async function (
  this: LwsWorld,
  name: string
) {
  const client = this.secretsManagerClient();
  const result = await client.send(new ListSecretsCommand({}));
  const names = (result.SecretList ?? []).map((s) => s.Name ?? "");
  assert.ok(!names.includes(name), `Expected secret "${name}" to not be in list`);
});

Then("the secret list will include {string}", function (this: LwsWorld, name: string) {
  const output = this.lastResult.output as { SecretList?: Array<{ Name?: string }> };
  const names = (output?.SecretList ?? []).map((s) => s.Name ?? "");
  assert.ok(names.includes(name), `Expected secret list to include "${name}"`);
});

Then("secret {string} will have tag {string} with value {string}", async function (
  this: LwsWorld,
  name: string,
  tagKey: string,
  expectedValue: string
) {
  const client = this.secretsManagerClient();
  const result = await client.send(new DescribeSecretCommand({ SecretId: name }));
  const tags = result.Tags ?? [];
  const tag = tags.find((t) => t.Key === tagKey);
  assert.strictEqual(tag?.Value, expectedValue);
});

Then("secret {string} will not have tag {string}", async function (
  this: LwsWorld,
  name: string,
  tagKey: string
) {
  const client = this.secretsManagerClient();
  const result = await client.send(new DescribeSecretCommand({ SecretId: name }));
  const tags = result.Tags ?? [];
  const tag = tags.find((t) => t.Key === tagKey);
  assert.ok(!tag, `Expected tag "${tagKey}" to not exist`);
});
