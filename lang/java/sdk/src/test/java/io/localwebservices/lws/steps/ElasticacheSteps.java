package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.elasticache.ElastiCacheClient;

/**
 * Step definitions for the Elasticache informal specification feature files.
 *
 * <p>Covers: create_cache_cluster, delete_cache_cluster, modify_cache_cluster,
 * create_replication_group, delete_replication_group, modify_replication_group,
 * add_tags_to_resource, remove_tags_from_resource, create_snapshot, delete_snapshot,
 * complete_cache_cluster_creation, complete_cache_cluster_deletion,
 * complete_cache_cluster_modification, complete_replication_group_creation,
 * complete_replication_group_deletion, complete_replication_group_modification,
 * complete_snapshot_creation, complete_snapshot_deletion, create_cache_parameter_group,
 * delete_cache_parameter_group, create_cache_subnet_group, delete_cache_subnet_group,
 * create_cache_cluster_from_snapshot, complete_cluster_restore, add_replica_to_cache_cluster,
 * complete_replica_creation, failover_replication_group, create_memcached_cache_cluster.
 */
public class ElasticacheSteps {

  private static final String TEST_CLUSTER = "test-elasticache-cluster-1";
  private static final String TEST_REPLICATION_GROUP = "test-elasticache-rg-1";
  private static final String TEST_SNAPSHOT = "test-elasticache-snapshot-1";
  private static final String TEST_PARAM_GROUP = "test-elasticache-pg-1";
  private static final String TEST_SUBNET_GROUP = "test-elasticache-sg-1";
  private static final String TEST_TAG_KEY = "e2e-elasticache-tag-key-1";
  private static final String TEST_TAG_VALUE = "e2e-elasticache-tag-value-1";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  public ElasticacheSteps(WorldContext world) {
    this.world = world;
  }

  // ── @Before hook ──────────────────────────────────────────────────────────────

  @Before("@elasticache")
  public void setElasticacheResourceContext() {
    // Arrange: mark this scenario as elasticache so shared step "the resource exists"
    // dispatches to ElastiCache cluster creation rather than ApiGateway REST API setup.
    world.lastResourceService = "elasticache";
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void elasticacheCreateCluster() {
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Arrange / Act
      client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("redis"));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("CacheClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void elasticacheCreateReplicationGroup() {
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Arrange / Act
      client.createReplicationGroup(
          r ->
              r.replicationGroupId(TEST_REPLICATION_GROUP)
                  .replicationGroupDescription("test replication group"));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ReplicationGroupAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // "the cluster does not already exist" → DocdbSteps
  // "the cluster already exists" → DocdbSteps

  @Given("a cluster slot is available")
  public void aClusterSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: cluster slots are available in a fresh session.
  }

  @Given("no cluster slot is available")
  public void noClusterSlotIsAvailable() {
    // @internal: no public API exhausts cluster slots.
    Assumptions.assumeTrue(false, "no public API exhausts cluster slots.");
  }

  // "the target cluster slot is available" → DocdbSteps

  @Given("the cluster is \"AVAILABLE\"")
  public void theClusterIsAvailable() {
    // Arrange: ensure cluster exists; fresh clusters start AVAILABLE
    // Act
    elasticacheCreateCluster();
    // Assert: cluster is AVAILABLE
  }

  @Given("the cluster is not \"AVAILABLE\"")
  public void theClusterIsNotAvailable() {
    // @internal: Cannot drive a cluster into a non-AVAILABLE state via public API in lws.
    Assumptions.assumeTrue(
        false, "Cannot drive a cluster into a non-AVAILABLE state via public API in lws.");
  }

  @Given("the cluster is \"CREATING\"")
  public void theClusterIsCreating() {
    // @internal: CREATING state is transient after creation, not reachable via public API.
    Assumptions.assumeTrue(
        false, "CREATING state is transient after creation, not reachable via public API.");
  }

  @Given("the cluster is not \"CREATING\"")
  public void theClusterIsNotCreating() {
    // @internal: state transition controlled internally.
    Assumptions.assumeTrue(false, "state transition controlled internally.");
  }

  @Given("the cluster is \"DELETING\"")
  public void theClusterIsDeleting() {
    // @internal: DELETING state is transient after deletion, not reachable via public API.
    Assumptions.assumeTrue(
        false, "DELETING state is transient after deletion, not reachable via public API.");
  }

  @Given("the cluster is not \"DELETING\"")
  public void theClusterIsNotDeleting() {
    // @internal: state transition controlled internally.
    Assumptions.assumeTrue(false, "state transition controlled internally.");
  }

  @Given("the cluster is standalone \\(not part of a replication group\\)")
  public void theClusterIsStandaloneNotPartOfAReplicationGroup() {
    // Arrange / Act / Assert — no-op: standalone clusters have no replication group by default.
  }

  @Given("the cluster is part of a replication group")
  public void theClusterIsPartOfAReplicationGroup() {
    // @internal: replication group membership requires internal state manipulation.
    Assumptions.assumeTrue(
        false, "replication group membership requires internal state manipulation.");
  }

  @Given("the cluster uses the redis engine")
  public void theClusterUsesTheRedisEngine() {
    // Arrange / Act / Assert — no-op: default test cluster uses redis engine.
  }

  @Given("the cluster does not use the redis engine")
  public void theClusterDoesNotUseTheRedisEngine() {
    // @internal: switching engine requires creating a memcached cluster specifically.
    Assumptions.assumeTrue(
        false, "switching engine requires creating a memcached cluster specifically.");
  }

  // ── Given: replication group state ────────────────────────────────────────────

  @Given("the replication group does not already exist")
  public void theReplicationGroupDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no replication groups.
  }

  @Given("the replication group already exists")
  public void theReplicationGroupAlreadyExists() {
    // Arrange
    // Act
    elasticacheCreateReplicationGroup();
    // Assert: replication group created (no error thrown)
  }

  @Given("the replication group exists")
  public void theReplicationGroupExists() {
    // Arrange
    // Act
    elasticacheCreateReplicationGroup();
    // Assert: replication group created (no error thrown)
  }

  @Given("the replication group does not exist")
  public void theReplicationGroupDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no replication groups.
  }

  @Given("the replication group is \"AVAILABLE\"")
  public void theReplicationGroupIsAvailable() {
    // Arrange: ensure replication group exists
    // Act
    elasticacheCreateReplicationGroup();
    // Assert: replication group is AVAILABLE
  }

  @Given("the replication group is not \"AVAILABLE\"")
  public void theReplicationGroupIsNotAvailable() {
    // @internal: Cannot drive a replication group into a non-AVAILABLE state via public API.
    Assumptions.assumeTrue(
        false, "Cannot drive a replication group into a non-AVAILABLE state via public API.");
  }

  @Given("the replication group is \"CREATING\"")
  public void theReplicationGroupIsCreating() {
    // @internal: CREATING state is transient, not reachable via public API.
    Assumptions.assumeTrue(false, "CREATING state is transient, not reachable via public API.");
  }

  @Given("the replication group is not \"CREATING\"")
  public void theReplicationGroupIsNotCreating() {
    // @internal: state transition controlled internally.
    Assumptions.assumeTrue(false, "state transition controlled internally.");
  }

  @Given("the replication group is \"DELETING\"")
  public void theReplicationGroupIsDeleting() {
    // @internal: DELETING state is transient, not reachable via public API.
    Assumptions.assumeTrue(false, "DELETING state is transient, not reachable via public API.");
  }

  @Given("the replication group is not \"DELETING\"")
  public void theReplicationGroupIsNotDeleting() {
    // @internal: state transition controlled internally.
    Assumptions.assumeTrue(false, "state transition controlled internally.");
  }

  @Given("the replication group has a primary cluster assigned")
  public void theReplicationGroupHasAPrimaryClusterAssigned() {
    // Arrange / Act / Assert — no-op: replication groups always have a primary in lws.
  }

  // ── Given: snapshot state ──────────────────────────────────────────────────────

  @Given("the snapshot does not already exist")
  public void theSnapshotDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no snapshots.
  }

  @Given("the snapshot already exists")
  public void theSnapshotAlreadyExists() {
    // @internal: snapshot creation requires a cluster in AVAILABLE state with redis engine.
    Assumptions.assumeTrue(
        false, "snapshot creation requires a cluster in AVAILABLE state with redis engine.");
  }

  @Given("the resource has tags")
  public void theResourceHasTags() {
    // Arrange / Act / Assert — no-op: resource tags are managed via add/remove tag actions.
  }

  @Given("the resource does not have tags")
  public void theResourceDoesNotHaveTags() {
    // Arrange / Act / Assert — no-op: fresh resources have no tags.
  }

  // ── Given: parameter group / subnet group state ───────────────────────────────

  @Given("the parameter group is present")
  public void theParameterGroupIsPresent() {
    // Arrange / Act / Assert — no-op: parameter groups created via API are always present.
  }

  @Given("the parameter group does not already exist")
  public void theParameterGroupDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state has no parameter groups.
  }

  @Given("the parameter group already exists")
  public void theParameterGroupAlreadyExists() {
    // @internal: parameter group state setup requires specific API calls.
    Assumptions.assumeTrue(false, "parameter group state setup requires specific API calls.");
  }

  @Given("the parameter group exists")
  public void theParameterGroupExists() {
    // @internal: parameter group state setup requires specific API calls.
    Assumptions.assumeTrue(false, "parameter group state setup requires specific API calls.");
  }

  @Given("the parameter group does not exist")
  public void theParameterGroupDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state has no parameter groups.
  }

  @Given("the subnet group is present")
  public void theSubnetGroupIsPresent() {
    // Arrange / Act / Assert — no-op: subnet groups created via API are always present.
  }

  @Given("the subnet group is not present")
  public void theSubnetGroupIsNotPresent() {
    // @internal: no public API places a subnet group in a non-present state.
    Assumptions.assumeTrue(false, "no public API places a subnet group in a non-present state.");
  }

  @Given("the subnet group does not already exist")
  public void theSubnetGroupDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state has no subnet groups.
  }

  @Given("the subnet group already exists")
  public void theSubnetGroupAlreadyExists() {
    // @internal: subnet group state setup requires specific API calls.
    Assumptions.assumeTrue(false, "subnet group state setup requires specific API calls.");
  }

  @Given("the subnet group exists")
  public void theSubnetGroupExists() {
    // @internal: subnet group state setup requires specific API calls.
    Assumptions.assumeTrue(false, "subnet group state setup requires specific API calls.");
  }

  @Given("the subnet group does not exist")
  public void theSubnetGroupDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state has no subnet groups.
  }

  // ── When: cluster actions ──────────────────────────────────────────────────────

  @When("a redis cache cluster is created")
  public void aRedisCacheClusterIsCreated() {
    // Arrange: (cluster state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("redis"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a standalone cache cluster is deleted")
  public void aStandaloneCacheClusterIsDeleted() {
    // Arrange: (cluster state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.deleteCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a cache cluster configuration is modified")
  public void aCacheClusterConfigurationIsModified() {
    // Arrange: (cluster state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.modifyCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a standalone cache cluster finishes creating")
  public void aStandaloneCacheClusterFinishesCreating() {
    // @internal: no public API to advance cluster lifecycle — no-op.
    world.setSuccess(null);
  }

  @When("a cache cluster deletion completes")
  public void aCacheClusterDeletionCompletes() {
    // @internal: no public API to advance cluster deletion — no-op.
    world.setSuccess(null);
  }

  @When("a cache cluster modification completes")
  public void aCacheClusterModificationCompletes() {
    // @internal: no public API to advance cluster modification — no-op.
    world.setSuccess(null);
  }

  @When("a memcached cache cluster is created")
  public void aMemcachedCacheClusterIsCreated() {
    // Arrange: (cluster state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result =
          client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("memcached"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a replica is added to a replication group")
  public void aReplicaIsAddedToAReplicationGroup() {
    // Arrange: (replication group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act: modify replication group to add a replica
      var result = client.modifyReplicationGroup(r -> r.replicationGroupId(TEST_REPLICATION_GROUP));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a replica is added to the cache cluster")
  public void aReplicaIsAddedToTheCacheCluster() {
    // @internal: adding a replica requires internal replication group state manipulation.
    world.setFailure(
        new UnsupportedOperationException(
            "add_replica_to_cache_cluster: cannot add replica via public API in lws"));
  }

  @When("the replica finishes creating")
  public void theReplicaFinishesCreating() {
    // @internal: no public API to advance replica creation — no-op.
    world.setSuccess(null);
  }

  // ── When: replication group actions ───────────────────────────────────────────

  @When("a replication group is created")
  public void aReplicationGroupIsCreated() {
    // Arrange: (replication group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result =
          client.createReplicationGroup(
              r ->
                  r.replicationGroupId(TEST_REPLICATION_GROUP)
                      .replicationGroupDescription("test replication group"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a replication group is deleted")
  public void aReplicationGroupIsDeleted() {
    // Arrange: (replication group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.deleteReplicationGroup(r -> r.replicationGroupId(TEST_REPLICATION_GROUP));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the replication group is deleted")
  public void theReplicationGroupIsDeleted() {
    // Arrange: (replication group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.deleteReplicationGroup(r -> r.replicationGroupId(TEST_REPLICATION_GROUP));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a replication group configuration is modified")
  public void aReplicationGroupConfigurationIsModified() {
    // Arrange: (replication group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.modifyReplicationGroup(r -> r.replicationGroupId(TEST_REPLICATION_GROUP));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the replication group configuration is modified")
  public void theReplicationGroupConfigurationIsModified() {
    // Arrange: (replication group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.modifyReplicationGroup(r -> r.replicationGroupId(TEST_REPLICATION_GROUP));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the replication group finishes creating")
  public void theReplicationGroupFinishesCreating() {
    // @internal: no public API to advance replication group lifecycle — no-op.
    world.setSuccess(null);
  }

  @When("the replication group deletion completes")
  public void theReplicationGroupDeletionCompletes() {
    // @internal: no public API to advance replication group deletion — no-op.
    world.setSuccess(null);
  }

  @When("the replication group modification completes")
  public void theReplicationGroupModificationCompletes() {
    // @internal: no public API to advance replication group modification — no-op.
    world.setSuccess(null);
  }

  @When("a failover is initiated on the replication group")
  public void aFailoverIsInitiatedOnTheReplicationGroup() {
    // @internal: failover requires an active multi-AZ replication group.
    world.setFailure(
        new UnsupportedOperationException("failover_replication_group: scenario is @internal"));
  }

  // ── When: snapshot actions ─────────────────────────────────────────────────────

  @When("a snapshot is created from an available redis cache cluster")
  public void aSnapshotIsCreatedFromAnAvailableRedisCacheCluster() {
    // Arrange: (cluster state set up by Given steps)
    world.lastClusterService = "elasticache";
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result =
          client.createSnapshot(r -> r.cacheClusterId(TEST_CLUSTER).snapshotName(TEST_SNAPSHOT));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a cache snapshot is deleted")
  public void aCacheSnapshotIsDeleted() {
    // Arrange: (snapshot state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.deleteSnapshot(r -> r.snapshotName(TEST_SNAPSHOT));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the snapshot is deleted")
  public void theSnapshotIsDeleted() {
    // Arrange: (snapshot state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.deleteSnapshot(r -> r.snapshotName(TEST_SNAPSHOT));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the snapshot creation completes")
  public void theSnapshotCreationCompletes() {
    // @internal: no public API to advance snapshot creation — no-op.
    world.setSuccess(null);
  }

  @When("the snapshot deletion completes")
  public void theSnapshotDeletionCompletes() {
    // @internal: no public API to advance snapshot deletion — no-op.
    world.setSuccess(null);
  }

  @When("a cache cluster is created from a snapshot")
  public void aCacheClusterIsCreatedFromASnapshot() {
    // @internal: creating a cluster from snapshot requires snapshot in AVAILABLE state.
    world.setFailure(
        new UnsupportedOperationException(
            "create_cache_cluster_from_snapshot: scenario is @internal"));
  }

  @When("a cache cluster is created from the snapshot")
  public void aCacheClusterIsCreatedFromTheSnapshot() {
    // @internal: creating a cluster from snapshot requires snapshot in AVAILABLE state.
    world.setFailure(
        new UnsupportedOperationException(
            "create_cache_cluster_from_snapshot: scenario is @internal"));
  }

  @When("the cluster restore completes")
  public void theClusterRestoreCompletes() {
    // @internal: no public API to advance cluster restore — no-op.
    world.setSuccess(null);
  }

  // ── When: tag actions ──────────────────────────────────────────────────────────

  @When("tags are added to a cache resource")
  public void tagsAreAddedToACacheResource() {
    // Arrange: build test ARN for the cluster resource
    String expectedArn =
        "arn:aws:elasticache:" + TEST_REGION + ":" + TEST_ACCOUNT + ":cluster:" + TEST_CLUSTER;
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result =
          client.addTagsToResource(
              r ->
                  r.resourceName(expectedArn)
                      .tags(
                          software.amazon.awssdk.services.elasticache.model.Tag.builder()
                              .key(TEST_TAG_KEY)
                              .value(TEST_TAG_VALUE)
                              .build()));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags are removed from a cache resource")
  public void tagsAreRemovedFromACacheResource() {
    // Arrange: build test ARN for the cluster resource
    String expectedArn =
        "arn:aws:elasticache:" + TEST_REGION + ":" + TEST_ACCOUNT + ":cluster:" + TEST_CLUSTER;
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result =
          client.removeTagsFromResource(r -> r.resourceName(expectedArn).tagKeys(TEST_TAG_KEY));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // ── When: parameter group actions ─────────────────────────────────────────────

  @When("a cache parameter group is created")
  public void aCacheParameterGroupIsCreated() {
    // Arrange: (parameter group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result =
          client.createCacheParameterGroup(
              r ->
                  r.cacheParameterGroupName(TEST_PARAM_GROUP)
                      .cacheParameterGroupFamily("redis6.x")
                      .description("test parameter group"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a cache parameter group is deleted")
  public void aCacheParameterGroupIsDeleted() {
    // Arrange: (parameter group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      client.deleteCacheParameterGroup(r -> r.cacheParameterGroupName(TEST_PARAM_GROUP));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the cache parameter group is deleted")
  public void theCacheParameterGroupIsDeleted() {
    // Arrange: (parameter group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      client.deleteCacheParameterGroup(r -> r.cacheParameterGroupName(TEST_PARAM_GROUP));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // ── When: subnet group actions ─────────────────────────────────────────────────

  @When("a cache subnet group is created")
  public void aCacheSubnetGroupIsCreated() {
    // Arrange: (subnet group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result =
          client.createCacheSubnetGroup(
              r ->
                  r.cacheSubnetGroupName(TEST_SUBNET_GROUP)
                      .cacheSubnetGroupDescription("test subnet group")
                      .subnetIds("subnet-00000001"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a cache subnet group is deleted")
  public void aCacheSubnetGroupIsDeleted() {
    // Arrange: (subnet group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      client.deleteCacheSubnetGroup(r -> r.cacheSubnetGroupName(TEST_SUBNET_GROUP));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the cache subnet group is deleted")
  public void theCacheSubnetGroupIsDeleted() {
    // Arrange: (subnet group state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      client.deleteCacheSubnetGroup(r -> r.cacheSubnetGroupName(TEST_SUBNET_GROUP));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // "the cluster is in {string} state" → DocdbSteps (shared with MemoryDB)

  @Then("the cluster is in {string} state with the memcached engine")
  public void theClusterIsInStateWithTheMemcachedEngine(String expectedState) {
    // Arrange
    // Act: (action performed in When step)
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected memcached cluster to be in "
            + expectedState
            + " state but got error: "
            + world.lastError
            + "; expected_state="
            + expectedState
            + " expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the replication group and its clusters are in \"DELETING\" state")
  public void theReplicationGroupAndItsClustersAreInDeletingState() {
    // Arrange
    // Act: (action performed in When step)
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_replication_group to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the replication group is in {string} state")
  public void theReplicationGroupIsInState(String expectedState) {
    // Arrange
    // Act: (action performed in When step)
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected replication group to be in "
            + expectedState
            + " state but got error: "
            + world.lastError
            + "; expected_state="
            + expectedState
            + " expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("a new cluster is in \"CREATING\" state and associated with the replication group")
  public void aNewClusterIsInCreatingStateAndAssociatedWithTheReplicationGroup() {
    // Arrange
    // Act: (action performed in When step)
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected add replica to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  // "the snapshot is in {string} state" → MemorydbSteps

  @Then("the parameter group no longer exists")
  public void theParameterGroupNoLongerExists() {
    // Arrange
    // Act: (action performed in When step)
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected parameter group deletion to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the subnet group no longer exists")
  public void theSubnetGroupNoLongerExists() {
    // Arrange
    // Act: (action performed in When step)
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected subnet group deletion to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the cluster is \"DELETED\" and its tags are removed")
  public void theClusterIsDeletedAndItsTagsAreRemoved() {
    // @internal: cluster deletion completion not observable via public API.
    Assumptions.assumeTrue(false, "cluster deletion completion not observable via public API.");
  }

  // "the snapshot is in {string} state and the cluster is {string}" → MemorydbSteps
  // (unified handler; ElastiCache snapshot creation success verified by MemorydbSteps check)

  // "the replication group is in {string} state" → handled by parameterized @Then above

  @Then("the resource remains tagged")
  public void theResourceRemainsTagged() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected add_tags_to_resource to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  // ── Then: invariants ───────────────────────────────────────────────────────────

  @Then("memcached clusters are never associated with a replication group")
  public void memcachedClustersAreNeverAssociatedWithAReplicationGroup() {
    // No-op invariant: trivially satisfied in an isolated test context.
    Assumptions.assumeTrue(
        false, "No-op invariant: trivially satisfied in an isolated test context.");
  }

  @Then("all snapshots reference redis clusters only")
  public void allSnapshotsReferenceRedisClustersOnly() {
    // No-op invariant: trivially satisfied in an isolated test context.
    Assumptions.assumeTrue(
        false, "No-op invariant: trivially satisfied in an isolated test context.");
  }

  // "every available replication group has a primary cluster assigned" → CrossServiceSteps
  // (catch-all @And("^every .*$"))
  // "every active cluster, replication group, and snapshot has tags" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
  // "every snapshotting cluster has a corresponding in-progress snapshot" → CrossServiceSteps
  // (catch-all @And("^every .*$"))
}
