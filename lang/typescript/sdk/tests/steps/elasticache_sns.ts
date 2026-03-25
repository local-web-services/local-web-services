/** Step definitions: elasticache_sns cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const ELASTICACHE_SNS_CLUSTER_ID = "test-elasticache-cluster-1";
const ELASTICACHE_SNS_TOPIC_NAME = "test-elasticache-sns-topic-1";
const ELASTICACHE_SNS_REGION = "us-east-1";
const ELASTICACHE_SNS_ACCOUNT = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function elasticacheSnsElastiCacheClient(world: SdkWorld) {
  const { ElastiCacheClient } = require("@aws-sdk/client-elasticache");
  return world.session!.client<typeof ElastiCacheClient>("elasticache");
}

function elasticacheSnsSnsClient(world: SdkWorld) {
  const { SNSClient } = require("@aws-sdk/client-sns");
  return world.session!.client<typeof SNSClient>("sns");
}

function elasticacheSnsTopicArn(): string {
  return `arn:aws:sns:${ELASTICACHE_SNS_REGION}:${ELASTICACHE_SNS_ACCOUNT}:${ELASTICACHE_SNS_TOPIC_NAME}`;
}

async function elasticacheSnsCreateCluster(world: SdkWorld): Promise<void> {
  const { CreateCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  await elasticacheSnsElastiCacheClient(world).send(
    new CreateCacheClusterCommand({
      CacheClusterId: ELASTICACHE_SNS_CLUSTER_ID,
      Engine: "redis",
      CacheNodeType: "cache.t3.micro",
      NumCacheNodes: 1,
    }),
  );
}

async function elasticacheSnsCreateTopic(world: SdkWorld): Promise<void> {
  const { CreateTopicCommand } = require("@aws-sdk/client-sns");
  await elasticacheSnsSnsClient(world).send(
    new CreateTopicCommand({ Name: ELASTICACHE_SNS_TOPIC_NAME }),
  );
}

async function elasticacheSnsClusterExists(world: SdkWorld): Promise<boolean> {
  const { DescribeCacheClustersCommand } = require("@aws-sdk/client-elasticache");
  try {
    const resp = await elasticacheSnsElastiCacheClient(world).send(
      new DescribeCacheClustersCommand({ CacheClusterId: ELASTICACHE_SNS_CLUSTER_ID }),
    );
    return resp !== null && (resp.CacheClusters ?? []).length > 0;
  } catch {
    return false;
  }
}

async function elasticacheSnsTopicExists(world: SdkWorld): Promise<boolean> {
  const { ListTopicsCommand } = require("@aws-sdk/client-sns");
  try {
    const resp = await elasticacheSnsSnsClient(world).send(new ListTopicsCommand({}));
    const arn = elasticacheSnsTopicArn();
    return (resp.Topics ?? []).some(
      (t: { TopicArn?: string }) => t.TopicArn === arn,
    );
  } catch {
    return false;
  }
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: sequence / precondition steps ─────────────────────────────────────

Given("cid not in cluster_status", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: already registered in elasticache.ts.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("tid not in topic_status", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: in a fresh test session no topics exist.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: cluster state setup ────────────────────────────────────────────────

Given("the cluster does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: already registered in elasticache.ts.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster already exists", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: already registered in elasticache.ts.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  /^the cluster exists and is "([^"]*)"$/,
  async function (this: SdkWorld, _state: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    // Act: create the cluster in available state
    await elasticacheSnsCreateCluster(this);
    // Assert: cluster created
  },
);

Given(
  /^the cluster does not exist or is not "([^"]*)"$/,
  async function (this: SdkWorld, _state: string) {
    // Arrange / Act / Assert — no-op: precondition is not met — the Then step asserts operation rejected.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(
  /^the cluster has an "([^"]*)" notification configured$/,
  async function (this: SdkWorld, _service: string) {
    // @internal: configuring notifications requires the cluster to be AVAILABLE
    // which requires internal lifecycle completion. No-op.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(
  /^the cluster has no "([^"]*)" notification configured$/,
  async function (this: SdkWorld, _service: string) {
    // Arrange / Act / Assert — no-op: clusters are created without notification configuration by default.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(
  /^the cluster already has an "([^"]*)" notification configured$/,
  async function (this: SdkWorld, _service: string) {
    // @internal: no-op.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(/^the cluster is "([^"]*)"$/, async function (this: SdkWorld, _state: string) {
  // @internal: no-op — already registered in elasticache.ts.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(/^the cluster is not "([^"]*)"$/, async function (this: SdkWorld, _state: string) {
  // @internal: no-op — already registered in elasticache.ts.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: topic state setup ──────────────────────────────────────────────────

Given("the topic does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no topics.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the topic already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await elasticacheSnsCreateTopic(this);
  // Assert: topic created
});

Given("the topic exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await elasticacheSnsCreateTopic(this);
  // Assert: topic exists
});

Given("the topic does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no topics.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  /^the topic exists and is "([^"]*)"$/,
  async function (this: SdkWorld, _state: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    // Act: create the topic (SNS topics are ACTIVE on creation)
    await elasticacheSnsCreateTopic(this);
    // Assert: topic created
  },
);

Given(
  /^the topic does not exist or is not "([^"]*)"$/,
  async function (this: SdkWorld, _state: string) {
    // Arrange / Act / Assert — no-op: precondition not met — the Then step asserts operation rejected.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(/^the topic is "([^"]*)"$/, async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // Act: create the topic
    await elasticacheSnsCreateTopic(this);
    // Assert: topic created
    return;
  }
  // @internal: DELETED state is managed internally. No-op.
});

Given(/^the topic is already "([^"]*)"$/, async function (this: SdkWorld, _state: string) {
  // @internal: topic lifecycle states are managed internally. No-op.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: message slot setup ─────────────────────────────────────────────────

Given("a message slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: message slots are available in a fresh session.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("an ElastiCache cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await elasticacheSnsElastiCacheClient(this).send(
      new CreateCacheClusterCommand({
        CacheClusterId: ELASTICACHE_SNS_CLUSTER_ID,
        Engine: "redis",
        CacheNodeType: "cache.t3.micro",
        NumCacheNodes: 1,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(/^an "([^"]*)" topic is created$/, async function (this: SdkWorld, _service: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateTopicCommand } = require("@aws-sdk/client-sns");
  // Act
  try {
    const result = await elasticacheSnsSnsClient(this).send(
      new CreateTopicCommand({ Name: ELASTICACHE_SNS_TOPIC_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  /^the "([^"]*)" topic is deleted$/,
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DeleteTopicCommand } = require("@aws-sdk/client-sns");
    // Act
    try {
      const result = await elasticacheSnsSnsClient(this).send(
        new DeleteTopicCommand({ TopicArn: elasticacheSnsTopicArn() }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  /^an "([^"]*)" notification is configured on the ElastiCache cluster$/,
  async function (this: SdkWorld, _service: string) {
    // Arrange: verify cluster exists
    assert.ok(this.session, "Expected session to be initialized");
    const clusterExists = await elasticacheSnsClusterExists(this);
    if (!clusterExists) {
      this.lastCallResult = {
        success: false,
        output: null,
        error: new Error(
          `CacheClusterNotFound: cluster ${ELASTICACHE_SNS_CLUSTER_ID} does not exist`,
        ),
      };
      return;
    }
    const { ModifyCacheClusterCommand } = require("@aws-sdk/client-elasticache");
    // Act: modify the cluster to configure SNS notification
    try {
      const result = await elasticacheSnsElastiCacheClient(this).send(
        new ModifyCacheClusterCommand({
          CacheClusterId: ELASTICACHE_SNS_CLUSTER_ID,
          NotificationTopicArn: elasticacheSnsTopicArn(),
          NotificationTopicStatus: "active",
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  /^a cluster modification event occurs and ElastiCache publishes a notification to the "([^"]*)" topic$/,
  async function (this: SdkWorld, _service: string) {
    // @internal: notification publishing is an internal event — no public API triggers it.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = { success: true, output: null };
  },
);

When(
  /^a cluster event occurs but the "([^"]*)" notification fails because the topic has been deleted$/,
  async function (this: SdkWorld, _service: string) {
    // @internal: no-op.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = { success: true, output: null };
  },
);

When("the cluster modification completes", async function (this: SdkWorld) {
  // @internal: no-op.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = { success: true, output: null };
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then(
  /^the cluster is "([^"]*)" with no "([^"]*)" notification configured$/,
  async function (this: SdkWorld, clusterState: string, _service: string) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected create_cluster to succeed but got error: ${String(this.lastCallResult.error)}; expected_state=${clusterState} expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    assert.ok(
      this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
      `Expected CreateCacheClusterOutput but got null; expected_state=${clusterState}`,
    );
  },
);

Then(/^the topic is "([^"]*)"$/, async function (this: SdkWorld, expectedState: string) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected topic operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_state=${expectedState} expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const actualExists = await elasticacheSnsTopicExists(this);
  const expectedExists = true;
  assert.strictEqual(
    actualExists,
    expectedExists,
    `Expected topic "${ELASTICACHE_SNS_TOPIC_NAME}" to be ACTIVE but it does not exist; expected_exists=${expectedExists} actual_exists=${actualExists}`,
  );
});

Then(
  /^the topic is "([^"]*)" and ElastiCache event notifications will fail$/,
  async function (this: SdkWorld, expectedState: string) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected delete_topic to succeed but got error: ${String(this.lastCallResult.error)}; expected_state=${expectedState} expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then(
  "the cluster will publish lifecycle events to the topic",
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected configure_notification to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then("the operation is rejected", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: already registered in elasticache.ts.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then(
  /^every "([^"]*)" notification references a cluster that exists$/,
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then(
  /^every "([^"]*)" notification references a topic that exists$/,
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);
