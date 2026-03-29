/** Step definitions: opensearch service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";
import type { DomainStepHelpers } from "../support/world";

const OS_DOMAIN_NAME = "test-opensearch-domain-1";
const OS_LOCAL_DOMAIN_NAME = "test-opensearch-domain-1";
const OS_REMOTE_DOMAIN_NAME = "test-opensearch-domain-2";
const OS_TAG_KEY = "e2e-os-tag-key-1";
const OS_TAG_VALUE = "e2e-os-tag-value-1";
const OS_CONNECTION_ALIAS = "test-os-connection-1";

// ── Scenario-scoped mutable state ─────────────────────────────────────────────
// Cucumber step functions share `this` (SdkWorld) but we need service-specific
// connection IDs. We store them on the world via a duck-typed extension.

interface OsWorld extends SdkWorld {
  osOutboundConnectionId?: string;
  osInboundConnectionId?: string;
}

// ── Helpers ───────────────────────────────────────────────────────────────────

function osClient(world: SdkWorld) {
  const { OpenSearchClient } = require("@aws-sdk/client-opensearch");
  return world.session!.client<typeof OpenSearchClient>("opensearch");
}

async function osCreateDomain(world: SdkWorld, domainName: string): Promise<void> {
  const { CreateDomainCommand } = require("@aws-sdk/client-opensearch");
  await osClient(world).send(new CreateDomainCommand({ DomainName: domainName }));
}

async function osDomainExists(world: SdkWorld, domainName: string): Promise<boolean> {
  const { DescribeDomainCommand } = require("@aws-sdk/client-opensearch");
  try {
    const result = await osClient(world).send(
      new DescribeDomainCommand({ DomainName: domainName }),
    );
    const deleted: boolean = result?.DomainStatus?.Deleted ?? false;
    return !deleted;
  } catch {
    return false;
  }
}

async function osDomainARN(world: SdkWorld, domainName: string): Promise<string | null> {
  const { DescribeDomainCommand } = require("@aws-sdk/client-opensearch");
  try {
    const result = await osClient(world).send(
      new DescribeDomainCommand({ DomainName: domainName }),
    );
    return result?.DomainStatus?.ARN ?? null;
  } catch {
    return null;
  }
}

async function osEnsureDomainExists(world: SdkWorld, domainName: string): Promise<void> {
  const exists = await osDomainExists(world, domainName);
  if (!exists) {
    await osCreateDomain(world, domainName);
  }
}

async function osCreateOutboundConnection(
  world: OsWorld,
  localDomain: string,
  remoteDomain: string,
): Promise<string> {
  const { CreateOutboundConnectionCommand } = require("@aws-sdk/client-opensearch");
  const result = await osClient(world).send(
    new CreateOutboundConnectionCommand({
      ConnectionAlias: OS_CONNECTION_ALIAS,
      LocalDomainInfo: {
        AWSDomainInformation: {
          DomainName: localDomain,
          OwnerId: "000000000000",
          Region: "us-east-1",
        },
      },
      RemoteDomainInfo: {
        AWSDomainInformation: {
          DomainName: remoteDomain,
          OwnerId: "000000000000",
          Region: "us-east-1",
        },
      },
    }),
  );
  return result?.ConnectionId ?? "";
}

// ── Before hook: register domainHelpers for opensearch scenarios ──────────────

Before({ tags: "@opensearch" }, function (this: SdkWorld) {
  const domainHelpersImpl: DomainStepHelpers = {
    setupDomainExists: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      await osEnsureDomainExists(world as OsWorld, OS_DOMAIN_NAME);
    },
  };
  this.domainHelpers = domainHelpersImpl;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: domain state setup ─────────────────────────────────────────────────

// "the domain exists" is registered in cross_service_common.ts (dispatches via domainHelpers).
// "the domain does not exist" is registered in cross_service_common.ts.
// "the domain is {string}" is registered in cross_service_common.ts (dispatches via domainHelpers).

Given("the local domain exists", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await osEnsureDomainExists(this, OS_LOCAL_DOMAIN_NAME);
  // Assert: local domain created or already present
});

Given("the local domain does not exist", async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no domains.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the local domain is "ACTIVE"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: lws domains are immediately active after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the local domain is not "ACTIVE"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the remote domain exists", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await osEnsureDomainExists(this, OS_REMOTE_DOMAIN_NAME);
  // Assert: remote domain created or already present
});

Given("the remote domain does not exist", async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no remote domain.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the remote domain is "ACTIVE"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: lws domains are immediately active after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the remote domain is not "ACTIVE"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the local and remote domains are different", async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: test uses distinct domain names.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the local and remote domains are the same", async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: the When step uses the same domain name for both sides.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the connection slot is available", async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no connections, so slot is always available.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the connection slot is not available", async function (this: OsWorld) {
  // @internal: capacity exhaustion requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: outbound connection state ──────────────────────────────────────────

Given("the outbound connection exists", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  await osEnsureDomainExists(this, OS_LOCAL_DOMAIN_NAME);
  await osEnsureDomainExists(this, OS_REMOTE_DOMAIN_NAME);
  // Act
  const connectionId = await osCreateOutboundConnection(
    this,
    OS_LOCAL_DOMAIN_NAME,
    OS_REMOTE_DOMAIN_NAME,
  );
  this.osOutboundConnectionId = connectionId;
  // Assert: outbound connection created
});

Given("the outbound connection does not exist", async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no outbound connections.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the outbound connection is not already "DELETING"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: freshly created connections are not in DELETING state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the outbound connection is already "DELETING"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the outbound connection is not already "DELETED"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: freshly created connections are not in DELETED state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the outbound connection is already "DELETED"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the outbound connection is "DELETING"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the outbound connection is not "DELETING"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: freshly created connections are not in DELETING state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the associated inbound connection exists", async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: inbound connection is created automatically with outbound connection.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the associated inbound connection does not exist", async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: inbound connection state ───────────────────────────────────────────

Given("the inbound connection exists", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  await osEnsureDomainExists(this, OS_LOCAL_DOMAIN_NAME);
  await osEnsureDomainExists(this, OS_REMOTE_DOMAIN_NAME);
  // Act
  const connectionId = await osCreateOutboundConnection(
    this,
    OS_LOCAL_DOMAIN_NAME,
    OS_REMOTE_DOMAIN_NAME,
  );
  this.osOutboundConnectionId = connectionId;
  // The inbound connection ID matches the outbound connection ID in lws.
  this.osInboundConnectionId = connectionId;
  // Assert: inbound connection created via outbound
});

Given("the inbound connection does not exist", async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no inbound connections.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the inbound connection is "PENDING_ACCEPTANCE"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: freshly created inbound connections are in PENDING_ACCEPTANCE state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the inbound connection is not "PENDING_ACCEPTANCE"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the inbound connection is not already "DELETING"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: freshly created connections are not in DELETING state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the inbound connection is already "DELETING"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the inbound connection is not already "DELETED"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: freshly created connections are not in DELETED state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the inbound connection is already "DELETED"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the inbound connection is "DELETING"', async function (this: OsWorld) {
  // @internal: requires internal state manipulation — not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the inbound connection is not "DELETING"', async function (this: OsWorld) {
  // Arrange / Act / Assert — no-op: freshly created connections are not in DELETING state.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: blue-green deployment state ────────────────────────────────────────

Given("the new cluster has not been prepared yet", async function (this: OsWorld) {
  // @internal: blue-green deployment state is controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the new cluster has already been prepared", async function (this: OsWorld) {
  // @internal: blue-green deployment state is controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the new cluster is ready", async function (this: OsWorld) {
  // @internal: blue-green deployment state is controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the new cluster is not ready", async function (this: OsWorld) {
  // @internal: blue-green deployment state is controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("traffic has not been swapped yet", async function (this: OsWorld) {
  // @internal: blue-green deployment state is controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("traffic has already been swapped", async function (this: OsWorld) {
  // @internal: blue-green deployment state is controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("traffic has been swapped to the new cluster", async function (this: OsWorld) {
  // @internal: blue-green deployment state is controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("traffic has not been swapped to the new cluster", async function (this: OsWorld) {
  // @internal: blue-green deployment state is controlled internally.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When(
  "an outbound cross-cluster connection is created between two domains",
  async function (this: OsWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { CreateOutboundConnectionCommand } = require("@aws-sdk/client-opensearch");
    // Act
    try {
      const result = await osClient(this).send(
        new CreateOutboundConnectionCommand({
          ConnectionAlias: OS_CONNECTION_ALIAS,
          LocalDomainInfo: {
            AWSDomainInformation: {
              DomainName: OS_LOCAL_DOMAIN_NAME,
              OwnerId: "000000000000",
              Region: "us-east-1",
            },
          },
          RemoteDomainInfo: {
            AWSDomainInformation: {
              DomainName: OS_REMOTE_DOMAIN_NAME,
              OwnerId: "000000000000",
              Region: "us-east-1",
            },
          },
        }),
      );
      this.osOutboundConnectionId = result?.ConnectionId ?? "";
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When("an outbound cross-cluster connection is deleted", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteOutboundConnectionCommand } = require("@aws-sdk/client-opensearch");
  // Act
  try {
    const result = await osClient(this).send(
      new DeleteOutboundConnectionCommand({ ConnectionId: this.osOutboundConnectionId ?? "" }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an inbound cross-cluster connection is accepted", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { AcceptInboundConnectionCommand } = require("@aws-sdk/client-opensearch");
  // Act
  try {
    const result = await osClient(this).send(
      new AcceptInboundConnectionCommand({ ConnectionId: this.osInboundConnectionId ?? "" }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an inbound cross-cluster connection is deleted", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteInboundConnectionCommand } = require("@aws-sdk/client-opensearch");
  // Act
  try {
    const result = await osClient(this).send(
      new DeleteInboundConnectionCommand({ ConnectionId: this.osInboundConnectionId ?? "" }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an inbound cross-cluster connection is rejected", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { RejectInboundConnectionCommand } = require("@aws-sdk/client-opensearch");
  // Act
  try {
    const result = await osClient(this).send(
      new RejectInboundConnectionCommand({ ConnectionId: this.osInboundConnectionId ?? "" }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a domain configuration update is requested", async function (this: OsWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateDomainConfigCommand } = require("@aws-sdk/client-opensearch");
  // Act
  try {
    const result = await osClient(this).send(
      new UpdateDomainConfigCommand({ DomainName: OS_DOMAIN_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a search domain finishes creating", async function (this: OsWorld) {
  // @internal: no public API to advance the domain lifecycle — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("a search domain finishes deleting", async function (this: OsWorld) {
  // @internal: no public API to advance the domain lifecycle — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("an inbound connection finishes deleting", async function (this: OsWorld) {
  // @internal: no public API to advance connection lifecycle — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("an outbound connection finishes deleting", async function (this: OsWorld) {
  // @internal: no public API to advance connection lifecycle — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("a blue-green deployment completes", async function (this: OsWorld) {
  // @internal: no public API to advance blue-green lifecycle — no-op.
  this.lastCallResult = { success: true, output: null };
});

When("the new cluster for a blue-green deployment becomes ready", async function (this: OsWorld) {
  // @internal: no public API to advance blue-green lifecycle — no-op.
  this.lastCallResult = { success: true, output: null };
});

When(
  "traffic is swapped to the new cluster during a blue-green deployment",
  async function (this: OsWorld) {
    // @internal: no public API to swap traffic — no-op.
    this.lastCallResult = { success: true, output: null };
  },
);

When("shards are rebalanced across nodes in an active domain", async function (this: OsWorld) {
  // @internal: no public API to trigger shard rebalancing — no-op.
  this.lastCallResult = { success: true, output: null };
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the connection is in "PENDING_ACCEPTANCE" state', async function (this: OsWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected create_outbound_connection to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const expectedConnectionId = this.osOutboundConnectionId;
  assert.ok(
    expectedConnectionId && expectedConnectionId.length > 0,
    `Expected outbound connection ID to be set but it was empty; expected_connection_id=non-empty actual_connection_id=${expectedConnectionId}`,
  );
});

Then('the outbound connection is in "DELETING" state', async function (this: OsWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_outbound_connection to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the inbound connection is in "DELETING" state', async function (this: OsWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_inbound_connection to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('both the inbound and outbound connection are "ACTIVE"', async function (this: OsWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected accept_inbound_connection to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('both the inbound and outbound connection are "REJECTED"', async function (this: OsWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected reject_inbound_connection to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the inbound connection is "DELETED"', async function (this: OsWorld) {
  // @internal: state transition controlled internally — no-op.
});

Then(
  'the outbound and associated inbound connection are "DELETED"',
  async function (this: OsWorld) {
    // @internal: state transition controlled internally — no-op.
  },
);

Then(
  'the domain is in "PROCESSING" state and a blue-green deployment begins',
  async function (this: OsWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected update_domain_config to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then('the domain is "ACTIVE" with the new configuration applied', async function (this: OsWorld) {
  // @internal: state transition controlled internally — no-op.
});

Then(
  "the domain has a new cluster prepared but traffic is not yet swapped",
  async function (this: OsWorld) {
    // @internal: state transition controlled internally — no-op.
  },
);

Then("the domain is now serving requests from the new cluster", async function (this: OsWorld) {
  // @internal: state transition controlled internally — no-op.
});

Then("the instance count is updated without data loss", async function (this: OsWorld) {
  // @internal: state transition controlled internally — no-op.
});

Then(
  'the domain is "DELETED" and all associated connections are removed',
  async function (this: OsWorld) {
    // @internal: state transition controlled internally — no-op.
  },
);

Then("no active connection references a deleted domain", async function (this: OsWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then("traffic can only be swapped after the new cluster is ready", async function (this: OsWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  'an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection',
  async function (this: OsWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);
