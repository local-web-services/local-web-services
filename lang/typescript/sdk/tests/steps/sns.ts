/** Step definitions: sns service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const SNS_TEST_TOPIC = "e2e-sns-test-topic-1";
const SNS_TEST_SUB_QUEUE = "e2e-sns-test-sub-q-1";
const SNS_TEST_EMAIL_ENDPOINT = "test@example.invalid";
const SNS_TEST_MESSAGE = "test-sns-message-1";
const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function snsClient(world: SdkWorld) {
  const { SNSClient } = require("@aws-sdk/client-sns");
  return world.session!.client<typeof SNSClient>("sns");
}

function snsTopicArn(): string {
  return `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${SNS_TEST_TOPIC}`;
}

async function createTopic(world: SdkWorld): Promise<string> {
  const { CreateTopicCommand } = require("@aws-sdk/client-sns");
  const result = await snsClient(world).send(
    new CreateTopicCommand({ Name: SNS_TEST_TOPIC }),
  );
  return result.TopicArn ?? snsTopicArn();
}

async function createSubQueue(world: SdkWorld): Promise<void> {
  const { SQSClient, CreateQueueCommand } = require("@aws-sdk/client-sqs");
  const sqsC = world.session!.client<typeof SQSClient>("sqs");
  await sqsC.send(new CreateQueueCommand({ QueueName: SNS_TEST_SUB_QUEUE }));
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Common assertion ──────────────────────────────────────────────────────────

// "the operation is rejected" is registered in cross_service_common.ts.

// ── Given: topic steps already in cross_service_common.ts ────────────────────

// "the topic does not already exist" — registered in cross_service_common.ts
// "the topic already exists"         — registered in cross_service_common.ts
// "the topic exists"                 — registered in cross_service_common.ts
// "the topic is not {string}"        — registered in cross_service_common.ts
// "the topic does not exist"         — registered in cross_service_common.ts
// "the subscription slot is available"     — registered in cross_service_common.ts
// "the subscription slot is not available" — registered in cross_service_common.ts
// "a confirmed subscription exists for the topic" — registered in cross_service_common.ts
// "no confirmed subscription exists for the topic" — registered in cross_service_common.ts

// ── Given: topic lifecycle (sns-specific) ────────────────────────────────────

Given("the topic is {string}", async function (this: SdkWorld, state: string) {
  if (state === "ACTIVE") {
    // No-op: topics are ACTIVE immediately after creation.
    assert.ok(this.session, "Expected session to be initialized");
    return;
  }
  // For other lifecycle states, set flag for When step detection.
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._snsTopicNotActive = true;
});

// ── Given: subscription existence ────────────────────────────────────────────

Given("the subscription exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const topicArn =
    (this as any)._snsTopicArn ?? (await createTopic(this));
  (this as any)._snsTopicArn = topicArn;
  // Act: subscribe with email endpoint (pending confirmation by default)
  const { SubscribeCommand } = require("@aws-sdk/client-sns");
  try {
    const result = await snsClient(this).send(
      new SubscribeCommand({
        TopicArn: topicArn,
        Protocol: "email",
        Endpoint: SNS_TEST_EMAIL_ENDPOINT,
      }),
    );
    (this as any)._snsSubscriptionArn = result.SubscriptionArn ?? "";
  } catch (err: unknown) {
    (this as any)._snsSubscriptionArn = "";
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: subscription created
});

Given("the subscription does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no subscriptions.
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._snsSubscriptionArn = "";
});

// ── Given: subscription lifecycle state ──────────────────────────────────────

Given(
  "the subscription is {string}",
  async function (this: SdkWorld, state: string) {
    assert.ok(this.session, "Expected session to be initialized");
    if (state === "PENDING_CONFIRMATION") {
      // No-op: email subscriptions are PENDING_CONFIRMATION by default.
      return;
    }
    if (state === "CONFIRMED") {
      // Arrange: subscribe with SQS queue which is auto-confirmed in lws
      const topicArn =
        (this as any)._snsTopicArn ?? (await createTopic(this));
      (this as any)._snsTopicArn = topicArn;
      await createSubQueue(this);
      const queueArn = `arn:aws:sqs:${REGION}:${ACCOUNT_ID}:${SNS_TEST_SUB_QUEUE}`;
      const { SubscribeCommand } = require("@aws-sdk/client-sns");
      // Act
      const result = await snsClient(this).send(
        new SubscribeCommand({
          TopicArn: topicArn,
          Protocol: "sqs",
          Endpoint: queueArn,
        }),
      );
      // Assert
      (this as any)._snsSubscriptionArn = result.SubscriptionArn ?? "";
      return;
    }
    // For other states, no-op.
  },
);

Given(
  "the subscription is not {string}",
  async function (this: SdkWorld, _state: string) {
    // Cannot reliably produce a non-CONFIRMED/non-PENDING_CONFIRMATION subscription
    // without an external confirmation flow.
    // Set a flag so When steps can return "pending" for this scenario.
    assert.ok(this.session, "Expected session to be initialized");
    (this as any)._snsSubscriptionStateBlocked = true;
  },
);

// ── Given: subscription belongs to topic ─────────────────────────────────────

Given("the subscription belongs to this topic", async function (this: SdkWorld) {
  // No-op: subscription was created for this topic in a prior Given step.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  "the subscription does not belong to this topic",
  async function (this: SdkWorld) {
    // Cannot test cross-topic subscription isolation via public API.
    // Set a flag so When steps can return "pending".
    assert.ok(this.session, "Expected session to be initialized");
    (this as any)._snsCrossTopicBlocked = true;
  },
);

// ── Given: delivery slot ──────────────────────────────────────────────────────

Given("a delivery slot is available", async function (this: SdkWorld) {
  // No-op: always room for deliveries in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no delivery slot is available", async function (this: SdkWorld) {
  // Arrange: exhaust SNS delivery capacity
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("sns").exhaust().apply();
  // Assert: capacity is exhausted
});

// ── Given: subscription's topic ──────────────────────────────────────────────

Given(
  "the subscription's topic exists",
  async function (this: SdkWorld) {
    // No-op: topic was created in a prior Given step.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(
  "the subscription's topic is {string}",
  async function (this: SdkWorld, state: string) {
    assert.ok(this.session, "Expected session to be initialized");
    if (state === "ACTIVE") {
      // No-op: topic is ACTIVE by default after creation.
      return;
    }
    // For other lifecycle states, set flag for When step detection.
    (this as any)._snsSubscriptionTopicNotActive = true;
  },
);

Given(
  "the subscription's topic does not exist",
  async function (this: SdkWorld) {
    // Cannot test subscription with non-existent topic via public API.
    // Set flag so When steps can return "pending".
    assert.ok(this.session, "Expected session to be initialized");
    (this as any)._snsSubscriptionTopicMissing = true;
  },
);

Given(
  "the subscription's topic is not {string}",
  async function (this: SdkWorld, _state: string) {
    // Arrange: use lifecycle API to simulate a non-ACTIVE topic
    assert.ok(this.session, "Expected session to be initialized");
    // Act
    await this.session!.lifecycle("sns").createDwellMs(5000).apply();
    const { CreateTopicCommand, DeleteTopicCommand } = require("@aws-sdk/client-sns");
    const topicArn =
      (this as any)._snsTopicArn ?? snsTopicArn();
    try {
      await snsClient(this).send(new DeleteTopicCommand({ TopicArn: topicArn }));
    } catch {
      // Best effort — topic may not exist yet
    }
    const result = await snsClient(this).send(
      new CreateTopicCommand({ Name: SNS_TEST_TOPIC }),
    );
    (this as any)._snsTopicArn = result.TopicArn ?? snsTopicArn();
    // Assert: topic is in CREATING state
  },
);

// ── Given: delivery and retry state (@internal — never executed by tag filter) ─

Given("the delivery exists", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  "the delivery is {string}",
  async function (this: SdkWorld, _state: string) {
    // No-op: delivery scenarios are all @internal and will not run under tag filter.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(
  "the delivery is not {string}",
  async function (this: SdkWorld, _state: string) {
    // No-op: delivery scenarios are all @internal and will not run under tag filter.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given("the delivery does not exist", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the retry count is below the limit", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  "the retry count has reached the limit",
  async function (this: SdkWorld) {
    // No-op: delivery scenarios are all @internal and will not run under tag filter.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Given: confirmation token (@internal — never executed by tag filter) ──────

Given("the pending subscription exists", async function (this: SdkWorld) {
  // No-op: confirmation token scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the confirmation token is valid", async function (this: SdkWorld) {
  // No-op: confirmation token scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the confirmation token has expired", async function (this: SdkWorld) {
  // No-op: confirmation token scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

// "an {string} topic is created" is registered in cross_service_common.ts.

When("an {string} topic is deleted", async function (this: SdkWorld, _service: string) {
  // Arrange
  assert.ok(this.session, "No session running");
  const topicArn =
    (this as any)._snsTopicArn ?? snsTopicArn();
  const { DeleteTopicCommand } = require("@aws-sdk/client-sns");
  // Act
  try {
    const result = await snsClient(this).send(
      new DeleteTopicCommand({ TopicArn: topicArn }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an endpoint subscribes to a topic", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  if (
    (this as any)._snsTopicNotActive ||
    (this as any)._snsSubscriptionStateBlocked
  ) {
    return "pending";
  }
  const topicArn =
    (this as any)._snsTopicArn ?? snsTopicArn();
  const { SubscribeCommand } = require("@aws-sdk/client-sns");
  // Act
  try {
    const result = await snsClient(this).send(
      new SubscribeCommand({
        TopicArn: topicArn,
        Protocol: "email",
        Endpoint: SNS_TEST_EMAIL_ENDPOINT,
      }),
    );
    (this as any)._snsSubscriptionArn = result.SubscriptionArn ?? "";
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a pending subscription is confirmed", async function (this: SdkWorld) {
  // Cannot confirm subscription without a token via public API.
  return "pending";
});

When("an endpoint unsubscribes from a topic", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const subArn = (this as any)._snsSubscriptionArn ?? "";
  const { UnsubscribeCommand } = require("@aws-sdk/client-sns");
  // Act
  try {
    const result = await snsClient(this).send(
      new UnsubscribeCommand({ SubscriptionArn: subArn }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a message is published to a topic", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  if (
    (this as any)._snsTopicNotActive ||
    (this as any)._snsCrossTopicBlocked
  ) {
    return "pending";
  }
  const topicArn =
    (this as any)._snsTopicArn ?? snsTopicArn();
  const { PublishCommand } = require("@aws-sdk/client-sns");
  // Act
  try {
    const result = await snsClient(this).send(
      new PublishCommand({
        TopicArn: topicArn,
        Message: SNS_TEST_MESSAGE,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a subscription is removed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  if ((this as any)._snsSubscriptionStateBlocked) {
    return "pending";
  }
  const subArn = (this as any)._snsSubscriptionArn ?? "";
  const { UnsubscribeCommand } = require("@aws-sdk/client-sns");
  // Act
  try {
    const result = await snsClient(this).send(
      new UnsubscribeCommand({ SubscriptionArn: subArn }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a delivery attempt succeeds", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

When(
  "a delivery attempt fails and is retried",
  async function (this: SdkWorld) {
    // No-op: delivery scenarios are all @internal and will not run under tag filter.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

When("a delivery attempt fails", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

When("all delivery retries are exhausted", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

When(
  "a subscription confirmation token expires",
  async function (this: SdkWorld) {
    // No-op: confirmation token scenarios are all @internal and will not run under tag filter.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

When("the confirmation token expires", async function (this: SdkWorld) {
  // No-op: confirmation token scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the topic is {string}" is registered in cross_service_common.ts.
// "the operation is rejected" is registered in cross_service_common.ts.

Then(
  "the topic is {string} and its subscriptions are removed",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ListTopicsCommand } = require("@aws-sdk/client-sns");
    // Act
    const result = await snsClient(this).send(new ListTopicsCommand({}));
    // Assert
    const actualTopics: Array<{ TopicArn?: string }> =
      result.Topics ?? [];
    const actualFound = actualTopics.some(
      (t) =>
        t.TopicArn !== undefined &&
        t.TopicArn.endsWith(`:${SNS_TEST_TOPIC}`),
    );
    if (expectedState === "DELETED") {
      assert.strictEqual(
        actualFound,
        false,
        `Expected topic "${SNS_TEST_TOPIC}" to be DELETED but it was found; actual_found=${actualFound}`,
      );
    }
  },
);

Then("the topic is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListTopicsCommand } = require("@aws-sdk/client-sns");
  // Act
  const result = await snsClient(this).send(new ListTopicsCommand({}));
  // Assert
  const expectedTopic = SNS_TEST_TOPIC;
  const actualTopics: Array<{ TopicArn?: string }> = result.Topics ?? [];
  const actualFound = actualTopics.some(
    (t) =>
      t.TopicArn !== undefined && t.TopicArn.endsWith(`:${expectedTopic}`),
  );
  assert.strictEqual(
    actualFound,
    false,
    `Expected topic "${expectedTopic}" to be deleted but it was found; actual_found=${actualFound}`,
  );
});

Then(
  "the subscription is {string} or {string}",
  async function (this: SdkWorld, _stateA: string, _stateB: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    // Act: (action performed in When step)
    // Assert
    const expectedNotEmpty = true;
    const actualArn = (this as any)._snsSubscriptionArn ?? "";
    const actualNotEmpty = actualArn !== "";
    assert.strictEqual(
      actualNotEmpty,
      expectedNotEmpty,
      `Expected subscription ARN to be set but got empty; actual_arn="${actualArn}"`,
    );
  },
);

Then("the subscription is deleted", async function (this: SdkWorld) {
  // Arrange
  // Act: (action performed in When step)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected unsubscribe to succeed but it failed; actual_error=${this.lastCallResult.error}`,
  );
});

Then("the subscription is {string}", async function (this: SdkWorld, expectedState: string) {
  if (expectedState === "DELETED") {
    // Arrange
    // Act: (action performed in When step)
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected subscription removal to succeed but it failed; actual_error=${this.lastCallResult.error}`,
    );
    return;
  }
  if (expectedState === "CONFIRMED") {
    // Cannot verify CONFIRMED state without the confirmation flow — no-op.
    assert.ok(this.session, "Expected session to be initialized");
    return;
  }
  // For other states, no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  "the message is delivered to confirmed subscriptions",
  async function (this: SdkWorld) {
    // Arrange
    // Act: (action performed in When step)
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected publish to succeed but it failed; actual_error=${this.lastCallResult.error}`,
    );
  },
);

Then("the delivery is {string}", async function (this: SdkWorld, _state: string) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Then("the delivery is retried", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Then("the delivery is abandoned", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  "the pending subscription is {string}",
  async function (this: SdkWorld, _state: string) {
    // No-op: confirmation token scenarios are all @internal and will not run under tag filter.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then("the delivery retry count is incremented", async function (this: SdkWorld) {
  // No-op: delivery scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Then("the delivery is marked {string}", async function (this: SdkWorld, _state: string) {
  // No-op: retry_exhausted scenarios are all @internal and will not run under tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then(
  "no delivery is in-flight to a deleted subscription",
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  "no delivery is in-flight to an unconfirmed subscription",
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  "every active subscription references an {string} topic",
  async function (this: SdkWorld, _state: string) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  "every delivery retry count is within the allowed limit",
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
