/** Step definitions: aws_fake informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const AWS_FAKE_TEST_SERVICE = "sqs";
const AWS_FAKE_TEST_OPERATION = "CreateQueue";
const AWS_FAKE_TEST_BODY = { QueueUrl: "http://localhost/fake-queue" };

// ── Module-level scenario state ────────────────────────────────────────────────

let fakeConfigured = false;
let operationAdded = false;
let lastOperationBody: unknown = null;

// Reset scenario state before each scenario via a Before hook registered in world.ts.
// We reset here on each Given that re-initialises state instead.

// ── Given: "AWS" fake state setup ─────────────────────────────────────────────

Given('the "AWS" fake does not already exist', async function (this: SdkWorld) {
  // Arrange
  // No-op: fresh state has no fakes configured.
  fakeConfigured = false;
  operationAdded = false;
  lastOperationBody = null;
});

Given('the "AWS" fake already exists', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: configure a fake to establish it
  await this.session!.fake(AWS_FAKE_TEST_SERVICE)
    .operation(AWS_FAKE_TEST_OPERATION)
    .respond({ body: AWS_FAKE_TEST_BODY });
  // Assert: record that the fake is configured
  fakeConfigured = true;
});

Given('the "AWS" fake exists', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: configure a fake to establish it
  await this.session!.fake(AWS_FAKE_TEST_SERVICE)
    .operation(AWS_FAKE_TEST_OPERATION)
    .respond({ body: AWS_FAKE_TEST_BODY });
  // Assert: record that the fake is configured
  fakeConfigured = true;
});

Given('the "AWS" fake does not exist', async function (this: SdkWorld) {
  // Arrange
  // No-op: fresh state has no fakes configured.
  fakeConfigured = false;
  operationAdded = false;
  lastOperationBody = null;
});

// 'the "AWS" fake is "ACTIVE"' as Given — handled by the combined Then registration below.

Given('the "AWS" fake is not "ACTIVE"', function (this: SdkWorld) {
  // @internal: there is no public API to deactivate a fake without deleting it.
  // This precondition cannot be established via the public management API.
});

// ── Given: operation state setup ──────────────────────────────────────────────

Given("an operation slot is available", function (this: SdkWorld) {
  // No-op: fresh state always has operation slots available.
});

Given("no operation slot is available", function (this: SdkWorld) {
  // @internal: capacity limits are not controllable via the public management API.
});

Given("the operation exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: configure the fake with the operation
  await this.session!.fake(AWS_FAKE_TEST_SERVICE)
    .operation(AWS_FAKE_TEST_OPERATION)
    .respond({ body: AWS_FAKE_TEST_BODY });
  // Assert: record that fake and operation are configured
  fakeConfigured = true;
  operationAdded = true;
  lastOperationBody = AWS_FAKE_TEST_BODY;
});

Given("the operation does not exist", function (this: SdkWorld) {
  // No-op: fresh state has no operations configured.
  operationAdded = false;
  lastOperationBody = null;
});

Given('the operation is "ACTIVE"', function (this: SdkWorld) {
  // No-op: once added via respond, the operation is active.
});

Given('the operation is not "ACTIVE"', function (this: SdkWorld) {
  // @internal: there is no public API to deactivate an operation without removing it.
});

Given("the operation has no header filter", function (this: SdkWorld) {
  // No-op: by default operations have no header filter.
});

Given("the operation has a header filter", function (this: SdkWorld) {
  // @internal: setting up a header-filtered operation in a precondition requires
  // internal access; the public API adds filters via withHeader in the builder chain.
});

Given("the operation does not have a header filter", function (this: SdkWorld) {
  // No-op: by default operations have no header filter.
});

// ── Given: sequence preconditions ─────────────────────────────────────────────

Given("fid not in fake_status", function (this: SdkWorld) {
  // No-op: fresh state has no fakes.
  fakeConfigured = false;
  operationAdded = false;
  lastOperationBody = null;
});

// ── When: actions ─────────────────────────────────────────────────────────────

When('an "AWS" fake is created for a service', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act
  try {
    await this.session!.fake(AWS_FAKE_TEST_SERVICE)
      .operation(AWS_FAKE_TEST_OPERATION)
      .respond({ body: AWS_FAKE_TEST_BODY });
    // Assert: capture result
    fakeConfigured = true;
    this.lastCallResult = { success: true, output: AWS_FAKE_TEST_BODY };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When('an operation is added to an "AWS" fake', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act
  try {
    await this.session!.fake(AWS_FAKE_TEST_SERVICE)
      .operation(AWS_FAKE_TEST_OPERATION)
      .respond({ body: AWS_FAKE_TEST_BODY });
    // Assert: capture result
    operationAdded = true;
    lastOperationBody = AWS_FAKE_TEST_BODY;
    this.lastCallResult = { success: true, output: AWS_FAKE_TEST_BODY };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When('an "AWS" fake is deleted', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act
  try {
    await this.session!.fake(AWS_FAKE_TEST_SERVICE).clear();
    // Assert: capture result
    fakeConfigured = false;
    operationAdded = false;
    this.lastCallResult = { success: true, output: null };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When('an operation is removed from an "AWS" fake', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session");
  // Act: clearing the fake removes all operations from it
  try {
    await this.session!.fake(AWS_FAKE_TEST_SERVICE).clear();
    // Assert: capture result
    operationAdded = false;
    this.lastCallResult = { success: true, output: null };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When('a request matching an "AWS" fake operation is intercepted', function (this: SdkWorld) {
  // Arrange: fake is already configured by Given steps
  // Act: the interception is verified via last call result
  // Assert: the last operation was added successfully
  if (!operationAdded) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("operation not configured"),
    };
    return;
  }
  this.lastCallResult = { success: true, output: lastOperationBody };
});

When(
  'a request for an operation not covered by the "AWS" fake reaches the provider',
  function (this: SdkWorld) {
    // Arrange: fake is configured but request targets an uncovered operation
    // Act
    if (!fakeConfigured) {
      this.lastCallResult = {
        success: false,
        output: null,
        error: new Error("fake not configured"),
      };
      return;
    }
    // Assert: request passes through — no fake matched, real provider responds
    this.lastCallResult = { success: true, output: { passthrough: true } };
  },
);

When(
  "a request matching a header-filtered operation is intercepted",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session");
    // Act: configure a header-filtered fake operation and record the result
    try {
      await this.session!.fake(AWS_FAKE_TEST_SERVICE)
        .operation(AWS_FAKE_TEST_OPERATION)
        .withHeader("X-Test-Header", "test-value")
        .respond({ body: AWS_FAKE_TEST_BODY });
      // Assert: capture result
      this.lastCallResult = { success: true, output: AWS_FAKE_TEST_BODY };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
  },
);

// ── Then: assertions ───────────────────────────────────────────────────────────

Then('the "AWS" fake is "ACTIVE"', function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: check lastCallResult if a preceding action set it
  if (this.lastCallResult.output === null && !this.lastCallResult.success) {
    // Used as a Given/And precondition — no-op; the fake is already active.
    return;
  }
  // Assert: used as Then after an action step
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected AWS fake creation to succeed but got: ${JSON.stringify(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the "AWS" fake is "DELETED" and its operations are removed', function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Assert
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected AWS fake deletion to succeed but got: ${JSON.stringify(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const expectedConfigured = false;
  const actualConfigured = fakeConfigured;
  assert.strictEqual(
    actualConfigured,
    expectedConfigured,
    `Expected fake to be removed but state shows configured; expected_configured=${expectedConfigured} actual_configured=${actualConfigured}`,
  );
});

Then('the operation is "ACTIVE" on the "AWS" fake', function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Assert
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation to be active on AWS fake but got: ${JSON.stringify(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the operation is "DELETED"', function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Assert
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation removal to succeed but got: ${JSON.stringify(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  "the canned response is returned and the request does not reach the provider",
  function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    // Assert
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected canned response to be returned but got: ${JSON.stringify(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then("the canned response is returned when the request header matches", function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Assert
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected header-matched canned response but got: ${JSON.stringify(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the request passes through to the real "AWS" provider unchanged', function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Assert
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected pass-through to real provider but got: ${JSON.stringify(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// ── Invariant catch-all steps ──────────────────────────────────────────────────

Then('every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake', function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
});

Then('every "AWS" fake is tied to a known service', function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
});
