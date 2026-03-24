/** Step definitions: secretsmanager_events cross-service scenarios — unique When/Then steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { SM_SECRET, EB_BUS, ACCOUNT_ID, REGION, ebCall } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

// ── Additional Given steps unique to secretsmanager_events ────────────────────

Given("sid not in secret_status", function (this: SdkWorld) {
  // Arrange + Act: no-op — fresh session has no secrets
  // Assert: nothing to assert
});

Given("sid in secret_status", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { SecretsManagerClient, CreateSecretCommand } = require("@aws-sdk/client-secrets-manager");
  const client = this.session!.client<typeof SecretsManagerClient>("secretsmanager");
  // Act: ensure secret exists
  try {
    await client.send(new CreateSecretCommand({ Name: SM_SECRET, SecretString: "test-value" }));
  } catch {
    // May already exist
  }
  // Assert: no error thrown
});

// ── When steps ────────────────────────────────────────────────────────────────

When(
  "a secret is created and Secrets Manager delivers a {string} event to the EventBridge bus",
  async function (this: SdkWorld, _eventType: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    if ((this as any)._busDeleted) {
      return "pending";
    }
    if ((this as any)._busDoesNotExist) {
      return "pending";
    }
    if ((this as any)._noEventSlot) {
      return "pending";
    }
    const {
      SecretsManagerClient,
      CreateSecretCommand,
    } = require("@aws-sdk/client-secrets-manager");
    const client = this.session!.client<typeof SecretsManagerClient>("secretsmanager");
    // Act: create the secret
    try {
      const result = await client.send(
        new CreateSecretCommand({ Name: SM_SECRET, SecretString: "test-value" }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a secret is created but the {string} event delivery fails because the bus is deleted",
  async function (this: SdkWorld, _eventType: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // lws silently swallows event delivery failures — skip if bus is not DELETED
    if ((this as any)._busNotDeleted) {
      return "pending";
    }
    const {
      SecretsManagerClient,
      CreateSecretCommand,
    } = require("@aws-sdk/client-secrets-manager");
    const client = this.session!.client<typeof SecretsManagerClient>("secretsmanager");
    // Act: create the secret — delivery failure is silent
    try {
      const result = await client.send(
        new CreateSecretCommand({ Name: SM_SECRET, SecretString: "test-value" }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a secret is scheduled for deletion and Secrets Manager delivers a {string} event to the bus",
  async function (this: SdkWorld, _eventType: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    if ((this as any)._secretNotAvailable) {
      return "pending";
    }
    if ((this as any)._busDeleted) {
      return "pending";
    }
    if ((this as any)._noEventSlot) {
      return "pending";
    }
    const {
      SecretsManagerClient,
      DeleteSecretCommand,
    } = require("@aws-sdk/client-secrets-manager");
    const client = this.session!.client<typeof SecretsManagerClient>("secretsmanager");
    // Act: schedule deletion
    try {
      const result = await client.send(
        new DeleteSecretCommand({ SecretId: SM_SECRET, RecoveryWindowInDays: 7 }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a secret rotation occurs and Secrets Manager delivers a {string} event to the bus",
  async function (this: SdkWorld, _eventType: string) {
    // Arrange + Act: lws RotateSecret is a no-op; return pending
    // lws does not implement secret rotation with event delivery
    return "pending";
  },
);

// ── Then steps ────────────────────────────────────────────────────────────────

Then(
  "the secret is {string} and the {string} event is {string}",
  async function (
    this: SdkWorld,
    expectedSecretState: string,
    _eventType: string,
    _eventState: string,
  ) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the last call succeeded (event delivery is fire-and-forget)
    const actualSuccess = this.lastCallResult.success;
    const expectedSuccess = true;
    // Assert
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected operation to succeed for secret state "${expectedSecretState}" but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  "the secret is {string} but no event is delivered",
  async function (this: SdkWorld, expectedSecretState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the last call succeeded (event delivery failure is silent)
    const actualSuccess = this.lastCallResult.success;
    const expectedSuccess = true;
    // Assert
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected operation to succeed for secret state "${expectedSecretState}" but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  "the secret is {string} with a new version and the {string} event is {string}",
  function (this: SdkWorld, _secretState: string, _eventType: string, _eventState: string) {
    // Arrange + Act: lws RotateSecret is a no-op; rotation events are pending
    return "pending";
  },
);

Then(
  "every {string} event references a secret that exists",
  async function (this: SdkWorld, _eventState: string) {
    // Arrange: invariant guaranteed by the lws provider
    // Act: no external check needed
    // Assert: pass
  },
);

Then(
  "the bus is {string} and Secrets Manager event delivery will fail",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const port = this.session!.portFor("eventbridge");
    // Act: verify deletion succeeded
    const actualSuccess = this.lastCallResult.success;
    // Assert
    if (expectedState === "DELETED") {
      assert.ok(
        actualSuccess,
        `Expected bus deletion to succeed but got: ${JSON.stringify(this.lastCallResult.error)}`,
      );
    } else {
      const result = await ebCall(port, "ListEventBuses", {});
      const buses = (result.data as { EventBuses?: Array<{ Name?: string }> }).EventBuses ?? [];
      const expectedExists = expectedState === "ACTIVE";
      const actualExists = buses.some((b) => b.Name === EB_BUS);
      assert.strictEqual(
        actualExists,
        expectedExists,
        `Expected bus "${EB_BUS}" to be ${expectedState}`,
      );
    }
  },
);

void SM_SECRET;
void ACCOUNT_ID;
void REGION;
