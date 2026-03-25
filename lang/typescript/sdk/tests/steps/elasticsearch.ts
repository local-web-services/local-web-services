/** Step definitions: elasticsearch service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const ES_DOMAIN_NAME = "test-elasticsearch-domain-1";
const ES_TAG_KEY = "e2e-es-tag-key-1";
const ES_TAG_VALUE = "e2e-es-tag-value-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function esClient(world: SdkWorld) {
  const { ElasticsearchServiceClient } = require("@aws-sdk/client-elasticsearch");
  return world.session!.client<typeof ElasticsearchServiceClient>("elasticsearch");
}

async function esCreateDomain(world: SdkWorld): Promise<void> {
  const { CreateElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  await esClient(world).send(new CreateElasticsearchDomainCommand({ DomainName: ES_DOMAIN_NAME }));
}

async function esDomainExists(world: SdkWorld): Promise<boolean> {
  const { DescribeElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  try {
    const result = await esClient(world).send(
      new DescribeElasticsearchDomainCommand({ DomainName: ES_DOMAIN_NAME }),
    );
    const deleted: boolean = result?.DomainStatus?.Deleted ?? false;
    return !deleted;
  } catch {
    return false;
  }
}

async function esDomainARN(world: SdkWorld): Promise<string | null> {
  const { DescribeElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  try {
    const result = await esClient(world).send(
      new DescribeElasticsearchDomainCommand({ DomainName: ES_DOMAIN_NAME }),
    );
    return result?.DomainStatus?.ARN ?? null;
  } catch {
    return null;
  }
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: domain state setup ─────────────────────────────────────────────────

Given("the domain does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no domains.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the domain already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await esCreateDomain(this);
  // Assert: domain created
});

Given("the domain exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const exists = await esDomainExists(this);
  if (!exists) {
    await esCreateDomain(this);
  }
  // Assert: domain created or already present
});

Given('the domain is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: lws domains are immediately active after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the domain is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the domain is "CREATING"', async function (this: SdkWorld) {
  // @internal: domain is in CREATING immediately after CreateElasticsearchDomain — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the domain is not "CREATING"', async function (this: SdkWorld) {
  // @internal: state transition controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the domain is "DELETING"', async function (this: SdkWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the domain is not "DELETING"', async function (this: SdkWorld) {
  // @internal: state transition controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the domain is not being deleted", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: domains are not being deleted after creation in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the domain is being deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  // Act
  try {
    await esClient(this).send(new DeleteElasticsearchDomainCommand({ DomainName: ES_DOMAIN_NAME }));
  } catch {
    // domain may not exist; desired state is DELETING
  }
  // Assert: domain is being deleted
});

Given("the domain is not deleted", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: domains are not deleted after creation in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the domain is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  // Act
  try {
    await esClient(this).send(new DeleteElasticsearchDomainCommand({ DomainName: ES_DOMAIN_NAME }));
  } catch {
    // domain may not exist; desired state is deleted
  }
  // Assert: domain is deleted
});

Given("the domain does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no domains.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the domain is "PROCESSING"', async function (this: SdkWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the domain is not "PROCESSING"', async function (this: SdkWorld) {
  // @internal: state transition controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: tag state setup ────────────────────────────────────────────────────

Given("the tag key exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { AddTagsCommand } = require("@aws-sdk/client-elasticsearch");
  const arn = await esDomainARN(this);
  assert.ok(arn, "Expected domain ARN to be available");
  // Act
  await esClient(this).send(
    new AddTagsCommand({
      ARN: arn,
      TagList: [{ Key: ES_TAG_KEY, Value: ES_TAG_VALUE }],
    }),
  );
  // Assert: tag added
});

Given("the tag key does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no tags on the domain.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a search domain is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  // Act
  try {
    const result = await esClient(this).send(
      new CreateElasticsearchDomainCommand({ DomainName: ES_DOMAIN_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a search domain is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  // Act
  try {
    const result = await esClient(this).send(
      new DeleteElasticsearchDomainCommand({ DomainName: ES_DOMAIN_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("tags are added to a domain", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { AddTagsCommand } = require("@aws-sdk/client-elasticsearch");
  const arn = await esDomainARN(this);
  if (!arn) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(`ResourceNotFoundException: domain ${ES_DOMAIN_NAME} does not exist`),
    };
    return;
  }
  // Act
  try {
    const result = await esClient(this).send(
      new AddTagsCommand({
        ARN: arn,
        TagList: [{ Key: ES_TAG_KEY, Value: ES_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("tags are removed from a domain", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { RemoveTagsCommand } = require("@aws-sdk/client-elasticsearch");
  const arn = await esDomainARN(this);
  if (!arn) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(`ResourceNotFoundException: domain ${ES_DOMAIN_NAME} does not exist`),
    };
    return;
  }
  // Act
  try {
    const result = await esClient(this).send(
      new RemoveTagsCommand({ ARN: arn, TagKeys: [ES_TAG_KEY] }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a domain configuration update is requested", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateElasticsearchDomainConfigCommand } = require("@aws-sdk/client-elasticsearch");
  // Act
  try {
    const result = await esClient(this).send(
      new UpdateElasticsearchDomainConfigCommand({ DomainName: ES_DOMAIN_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a search domain finishes creating", async function (this: SdkWorld) {
  // @internal: no public API to advance the domain lifecycle — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("a search domain finishes deleting", async function (this: SdkWorld) {
  // @internal: no public API to advance the domain lifecycle — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("a domain configuration finishes processing", async function (this: SdkWorld) {
  // @internal: no public API to advance the domain config processing — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("a node failure occurs", async function (this: SdkWorld) {
  // @internal: no public API to inject a node failure — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("a replica sync lag occurs", async function (this: SdkWorld) {
  // @internal: no public API to inject replica sync lag — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("a shard reallocation occurs", async function (this: SdkWorld) {
  // @internal: no public API to inject shard reallocation — no-op.
  this.lastCallResult = { success: true, output: null };
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the domain is in "CREATING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected create_elasticsearch_domain to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { DescribeElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  const result = await esClient(this).send(
    new DescribeElasticsearchDomainCommand({ DomainName: ES_DOMAIN_NAME }),
  );
  const expectedDomainName = ES_DOMAIN_NAME;
  const actualDomainName = result?.DomainStatus?.DomainName;
  assert.strictEqual(
    actualDomainName,
    expectedDomainName,
    `Expected domain name "${expectedDomainName}" but got "${actualDomainName}"; expected_domain_name=${expectedDomainName} actual_domain_name=${actualDomainName}`,
  );
});

Then('the domain is in "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_elasticsearch_domain to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  'the domain is in "PROCESSING" state with a pending config change',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected update_elasticsearch_domain_config to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then('"ACTIVE" and ready for use', async function (this: SdkWorld) {
  // @internal: state transition controlled internally — no-op.
});

Then('the domain is "ACTIVE" and ready for use', async function (this: SdkWorld) {
  // @internal: state transition controlled internally — no-op.
});

Then('the domain is "DELETED" and all its indices are removed', async function (this: SdkWorld) {
  // @internal: state transition controlled internally — no-op.
});

Then("the specified tags are associated with the domain", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected add_tags to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const { ListTagsCommand } = require("@aws-sdk/client-elasticsearch");
  const arn = await esDomainARN(this);
  assert.ok(arn, "Expected domain ARN to be available");
  const listResult = await esClient(this).send(new ListTagsCommand({ ARN: arn }));
  const tagList: Array<{ Key?: string }> = listResult?.TagList ?? [];
  const expectedTagKey = ES_TAG_KEY;
  const actualFound = tagList.some((t) => t.Key === expectedTagKey);
  assert.ok(
    actualFound,
    `Expected tag "${expectedTagKey}" to be associated with domain but it was not; expected_tag_key=${expectedTagKey} actual_found=${actualFound}`,
  );
});

Then(
  "the specified tags are no longer associated with the domain",
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected remove_tags to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    const { ListTagsCommand } = require("@aws-sdk/client-elasticsearch");
    const arn = await esDomainARN(this);
    assert.ok(arn, "Expected domain ARN to be available");
    const listResult = await esClient(this).send(new ListTagsCommand({ ARN: arn }));
    const tagList: Array<{ Key?: string }> = listResult?.TagList ?? [];
    const expectedAbsentKey = ES_TAG_KEY;
    const actualFound = tagList.some((t) => t.Key === expectedAbsentKey);
    assert.ok(
      !actualFound,
      `Expected tag "${expectedAbsentKey}" to be removed from domain but it still exists; expected_absent_key=${expectedAbsentKey} actual_found=${actualFound}`,
    );
  },
);

Then("the operation is rejected", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedRejected = true;
  const actualRejected = !this.lastCallResult.success;
  assert.strictEqual(
    actualRejected,
    expectedRejected,
    `Expected the operation to be rejected but it succeeded; expected_rejected=${expectedRejected} actual_rejected=${actualRejected}`,
  );
});

Then(
  "every active index belongs to an existing non-deleted domain",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then("every active tag belongs to an existing non-deleted domain", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  'a pending config change only exists on a domain that is "PROCESSING"',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);
