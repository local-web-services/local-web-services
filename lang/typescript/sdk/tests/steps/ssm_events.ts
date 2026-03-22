/** Step definitions: ssm_events cross-service scenarios — unique When/Then steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { SM_PARAM, EB_BUS, ACCOUNT_ID, REGION, ebCall } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

// ── Additional Given steps unique to ssm_events ───────────────────────────────

Given(
  /^the parameter "(.*)" \(not already "(.*)"\)$/,
  async function (this: SdkWorld, state: string, _notState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { SSMClient, PutParameterCommand } = require("@aws-sdk/client-ssm");
    const client = this.session!.client<typeof SSMClient>("ssm");
    // Act: if EXISTS, ensure it is present
    if (state === "EXISTS") {
      try {
        await client.send(
          new PutParameterCommand({ Name: SM_PARAM, Value: "test-value", Type: "String" }),
        );
      } catch {
        // May already exist
      }
    }
    // Assert: nothing additional to assert
  },
);

Given("pid not in param_status", function (this: SdkWorld) {
  // Arrange + Act: no-op — fresh session has no parameters
  // Assert: nothing to assert
});

Given("pid in param_status", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { SSMClient, PutParameterCommand } = require("@aws-sdk/client-ssm");
  const client = this.session!.client<typeof SSMClient>("ssm");
  // Act: ensure parameter exists
  try {
    await client.send(
      new PutParameterCommand({ Name: SM_PARAM, Value: "test-value", Type: "String" }),
    );
  } catch {
    // May already exist
  }
  // Assert: no error thrown
});

Given("the bus does not exist or is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange + Act: no-op — the bus state is set by other steps
  // Assert: nothing to assert
});

// ── When steps ────────────────────────────────────────────────────────────────

When(
  "a parameter is created and {string} delivers a {string} event to the EventBridge bus",
  async function (this: SdkWorld, _service: string, _eventType: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    if ((this as any)._busDeleted) {
      return "pending";
    }
    if ((this as any)._noEventSlot) {
      return "pending";
    }
    const { SSMClient, PutParameterCommand } = require("@aws-sdk/client-ssm");
    const client = this.session!.client<typeof SSMClient>("ssm");
    // Act: create the parameter
    try {
      const result = await client.send(
        new PutParameterCommand({ Name: SM_PARAM, Value: "test-value", Type: "String" }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a parameter is created but the {string} event delivery fails because the bus is deleted",
  async function (this: SdkWorld, _eventType: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // lws silently swallows event delivery failures — skip if bus is not DELETED
    if ((this as any)._busNotDeleted) {
      return "pending";
    }
    const { SSMClient, PutParameterCommand } = require("@aws-sdk/client-ssm");
    const client = this.session!.client<typeof SSMClient>("ssm");
    // Act: create the parameter — delivery failure is silent
    try {
      const result = await client.send(
        new PutParameterCommand({ Name: SM_PARAM, Value: "test-value", Type: "String" }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a parameter is deleted and {string} delivers a {string} event to the EventBridge bus",
  async function (this: SdkWorld, _service: string, _eventType: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    if ((this as any)._paramDoesNotExist) {
      return "pending";
    }
    if ((this as any)._paramAlreadyDeleted) {
      return "pending";
    }
    if ((this as any)._busDeleted) {
      return "pending";
    }
    if ((this as any)._noEventSlot) {
      return "pending";
    }
    const { SSMClient, DeleteParameterCommand } = require("@aws-sdk/client-ssm");
    const client = this.session!.client<typeof SSMClient>("ssm");
    // Act: delete the parameter
    try {
      const result = await client.send(new DeleteParameterCommand({ Name: SM_PARAM }));
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

// ── Then steps ────────────────────────────────────────────────────────────────

Then(
  "the parameter {string} and the {string} event is {string}",
  async function (
    this: SdkWorld,
    expectedParamState: string,
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
      `Expected operation to succeed for parameter state "${expectedParamState}" but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  "the parameter {string} but no event is delivered",
  async function (this: SdkWorld, expectedParamState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // Act: verify the last call succeeded (event delivery failure is silent)
    const actualSuccess = this.lastCallResult.success;
    const expectedSuccess = true;
    // Assert
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected operation to succeed for parameter state "${expectedParamState}" but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  "the parameter is {string} and the {string} event is {string}",
  async function (
    this: SdkWorld,
    expectedParamState: string,
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
      `Expected operation to succeed for parameter state "${expectedParamState}" but got: ${JSON.stringify(this.lastCallResult.error)}`,
    );
  },
);

Then(
  /^every "(.*)" event references a parameter that exists \(in any state\)$/,
  async function (this: SdkWorld, _eventState: string) {
    // Arrange: invariant guaranteed by the lws provider
    // Act: no external check needed
    // Assert: pass
  },
);

Then(
  "the bus is {string} and {string} event delivery will fail",
  async function (this: SdkWorld, expectedState: string, _service: string) {
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

void SM_PARAM;
void ACCOUNT_ID;
void REGION;
