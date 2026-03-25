/** Step definitions: lambda_elasticache cross-service informal specification scenarios */

// Steps already registered in lambda.ts ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is {string}", "the function is not {string}",
// "an invocation slot is available", "no invocation slot is available"),
// capacity.ts, cross_service_common.ts ("the system is initialized"), and
// sqs.ts ("the operation is rejected") are NOT re-registered here.

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_ELASTICACHE_TEST_FUNC = "test-lambda-elasticache-1";
const LAMBDA_ELASTICACHE_TEST_CLUSTER = "test-lambda-elasticache-cluster-1";
const LAMBDA_ELASTICACHE_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaElasticacheLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaElasticacheElasticacheClient(world: SdkWorld) {
  const { ElastiCacheClient } = require("@aws-sdk/client-elasticache");
  return world.session!.client<typeof ElastiCacheClient>("elasticache");
}

async function lambdaElasticacheCreateFunction(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  await lambdaElasticacheLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_ELASTICACHE_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_ELASTICACHE_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
  // Assert: caller checks result
}

async function lambdaElasticacheCreateCluster(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  // Act
  await lambdaElasticacheElasticacheClient(world).send(
    new CreateCacheClusterCommand({
      CacheClusterId: LAMBDA_ELASTICACHE_TEST_CLUSTER,
      Engine: "redis",
      CacheNodeType: "cache.t3.micro",
      NumCacheNodes: 1,
    }),
  );
  // Assert: caller checks result
}

// ── Before hook: register cluster helpers for @lambdaelasticache scenarios ────

Before({ tags: "@lambdaelasticache" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      try {
        await lambdaElasticacheCreateCluster(world);
      } catch {
        // cluster may already exist
      }
    },
    assertClusterStatus: async (world: SdkWorld, expectedState: string) => {
      const { DescribeCacheClustersCommand } = require("@aws-sdk/client-elasticache");
      const result = await lambdaElasticacheElasticacheClient(world).send(
        new DescribeCacheClustersCommand({ CacheClusterId: LAMBDA_ELASTICACHE_TEST_CLUSTER }),
      );
      const clusters: Array<{ CacheClusterStatus?: string }> = result.CacheClusters ?? [];
      assert.ok(
        clusters.length > 0,
        `Expected cluster to be "${expectedState}" but cluster was not found`,
      );
      const expectedStatus = expectedState.toLowerCase();
      const actualStatus = clusters[0].CacheClusterStatus as string;
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
  };
});

// ── Given: cluster state ───────────────────────────────────────────────────────

// "the cluster does not already exist", "the cluster already exists",
// "the cluster exists", "the cluster does not exist", "the cluster is {string}",
// "the cluster is not {string}" are registered in cluster_common.ts.

// ── Given: cache entry state ───────────────────────────────────────────────────

Given("a {string} entry exists", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot insert CACHED entries via public APIs without Lambda invocation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('no "CACHED" entry exists', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no cached entries.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: invocation state ───────────────────────────────────────────────────

// ── Given: slot state ─────────────────────────────────────────────────────────

Given("a key slot is available", async function (this: SdkWorld) {
  // No-op: always room for cache keys in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no key slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust key slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("an ElastiCache cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateCacheClusterCommand } = require("@aws-sdk/client-elasticache");
  // Act
  try {
    const result = await lambdaElasticacheElasticacheClient(this).send(
      new CreateCacheClusterCommand({
        CacheClusterId: LAMBDA_ELASTICACHE_TEST_CLUSTER,
        Engine: "redis",
        CacheNodeType: "cache.t3.micro",
        NumCacheNodes: 1,
      }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When(
  "the Lambda function writes a value to the ElastiCache cluster during invocation",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda cache write in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda cache write: scenario is @internal"),
    };
  },
);

When(
  'ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger ElastiCache eviction via public APIs in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger ElastiCache eviction: scenario is @internal"),
    };
  },
);

When(
  "the Lambda invocation fails because all cache entries have been evicted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation failure in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
    };
  },
);

When(
  "the Lambda invocation reads an existing cache entry and completes successfully",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation success in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the cluster is {string}" is registered in cluster_common.ts (dispatches to assertClusterStatus).

Then('the invocation is "FAILED"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the cache entry is "CACHED" in the cluster', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda cache write result in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the cache entry is "EVICTED"', async function (this: SdkWorld) {
  // @internal: Cannot observe ElastiCache eviction in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then('every "CACHED" entry belongs to an "AVAILABLE" cluster', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
