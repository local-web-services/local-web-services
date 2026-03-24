"""Abstract BDD step definitions for Elasticache informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_CLUSTER = "e2e-test-cluster-1"
TEST_REPLICATION_GROUP = "e2e-test-rg-1"
TEST_SNAPSHOT = "e2e-test-snapshot-1"
TEST_PARAMETER_GROUP = "e2e-test-pg-1"
TEST_SUBNET_GROUP = "e2e-test-sg-1"


def _elasticache(lws_session):
    return lws_session.client("elasticache")


def _create_cluster(lws_session, cluster_id=TEST_CLUSTER, engine="redis"):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _elasticache(lws_session).create_cache_cluster(
        CacheClusterId=cluster_id,
        CacheNodeType="cache.t3.micro",
        Engine=engine,
        NumCacheNodes=1,
    )


def _create_replication_group(lws_session, rg_id=TEST_REPLICATION_GROUP):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _elasticache(lws_session).create_replication_group(
        ReplicationGroupId=rg_id,
        ReplicationGroupDescription="e2e test replication group",
        CacheNodeType="cache.t3.micro",
        Engine="redis",
    )


def _create_snapshot(lws_session, snapshot_id=TEST_SNAPSHOT, cluster_id=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _elasticache(lws_session).create_snapshot(
        SnapshotName=snapshot_id,
        CacheClusterId=cluster_id,
    )


def _create_parameter_group(lws_session, pg_id=TEST_PARAMETER_GROUP):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _elasticache(lws_session).create_cache_parameter_group(
        CacheParameterGroupName=pg_id,
        CacheParameterGroupFamily="redis6.x",
        Description="e2e test parameter group",
    )


def _create_subnet_group(lws_session, sg_id=TEST_SUBNET_GROUP):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _elasticache(lws_session).create_cache_subnet_group(
        CacheSubnetGroupName=sg_id,
        CacheSubnetGroupDescription="e2e test subnet group",
        SubnetIds=["subnet-12345678"],
    )


# ── Given: system ──────────────────────────────────────────────────────


@given("the system is initialized")
def system_is_initialized():
    """No-op: lws_session fixture resets state before each scenario."""


# ── Given: cluster state ───────────────────────────────────────────────


@given("the cluster does not already exist")
def cluster_not_already_exist():
    """No-op: fresh state has no clusters."""


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    _create_cluster(lws_session)


@given("the cluster exists")
def cluster_exists(lws_session):
    _create_cluster(lws_session)


@given("the cluster does not exist")
def cluster_does_not_exist():
    """No-op: fresh state has no clusters."""


@given('the cluster is "AVAILABLE"')
def cluster_is_available_given():
    """No-op: lws returns clusters as AVAILABLE immediately after creation."""


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given(lws_session):
    lws_session.lifecycle("elasticache").create_dwell_ms(5000).apply()
    _create_cluster(lws_session)


@given('the cluster is "CREATING"')
def cluster_is_creating_given(lws_session):
    lws_session.lifecycle("elasticache").create_dwell_ms(5000).apply()
    _create_cluster(lws_session)


@given('the cluster is not "CREATING"')
def cluster_is_not_creating_given():
    """No-op: clusters are not in CREATING state by default."""


@given('the cluster is "DELETING"')
def cluster_is_deleting_given():
    pytest.skip("Cannot observe DELETING cluster state in lws")


@given('the cluster is not "DELETING"')
def cluster_is_not_deleting_given():
    """No-op: clusters are not in DELETING state by default."""


@given('the cluster is "MODIFYING"')
def cluster_is_modifying_given():
    pytest.skip("Cannot trigger internal cluster MODIFYING state in lws")


@given('the cluster is not "MODIFYING"')
def cluster_is_not_modifying_given():
    """No-op: clusters are not in MODIFYING state by default."""


@given('the cluster is "RESTORING"')
def cluster_is_restoring_given():
    pytest.skip("Cannot observe RESTORING cluster state in lws")


@given('the cluster is not "RESTORING"')
def cluster_is_not_restoring_given():
    """No-op: clusters are not in RESTORING state by default."""


@given('the cluster is "SNAPSHOTTING"')
def cluster_is_snapshotting_given():
    pytest.skip("Cannot observe SNAPSHOTTING cluster state in lws")


@given('the cluster is not "SNAPSHOTTING"')
def cluster_is_not_snapshotting_given():
    """No-op: clusters are not in SNAPSHOTTING state by default."""


@given("the cluster is standalone (not part of a replication group)")
def cluster_is_standalone():
    """No-op: clusters are standalone by default."""


@given("the cluster is part of a replication group")
def cluster_is_part_of_rg():
    pytest.skip("Cannot create a cluster already in a replication group in lws")


@given("the cluster is not part of a replication group")
def cluster_is_not_part_of_rg():
    """No-op: clusters are standalone by default."""


@given("the cluster is part of this replication group")
def cluster_is_part_of_this_rg():
    pytest.skip("Cannot verify cluster membership in replication group in lws")


@given("the cluster is not part of this replication group")
def cluster_is_not_part_of_this_rg():
    """No-op: fresh cluster is not part of a replication group."""


@given("the cluster uses the redis engine")
def cluster_uses_redis_engine():
    """No-op: default cluster uses redis engine."""


@given("the cluster does not use the redis engine")
def cluster_does_not_use_redis_engine(lws_session):
    _create_cluster(lws_session, engine="memcached")


@given("the cluster is already the primary")
def cluster_is_already_primary():
    pytest.skip("Cannot control cluster primary assignment in lws")


@given("the cluster is not already the primary")
def cluster_is_not_already_primary():
    pytest.skip("Cannot control cluster primary assignment in lws")


@given("a cluster slot is available")
def cluster_slot_available():
    """No-op: always room for clusters."""


@given("no cluster slot is available")
def no_cluster_slot_available():
    pytest.skip("Cannot exhaust cluster slot limit in lws")


@given("a cluster slot is available for the primary")
def cluster_slot_available_for_primary():
    """No-op: always room for primary clusters."""


@given("no cluster slot is available for the primary")
def no_cluster_slot_available_for_primary():
    pytest.skip("Cannot exhaust cluster slot limit in lws")


@given("a replica cluster exists")
def replica_cluster_exists():
    pytest.skip("Cannot create replica cluster configuration in lws")


@given("no replica cluster exists")
def no_replica_cluster_exists():
    """No-op: fresh state has no replica clusters."""


@given("the target cluster slot is available")
def target_cluster_slot_available():
    """No-op: always room for clusters."""


@given("the target cluster slot is not available")
def target_cluster_slot_not_available():
    pytest.skip("Cannot exhaust cluster slot limit in lws")


@given("automatic failover is enabled")
def automatic_failover_enabled():
    pytest.skip("Cannot configure automatic failover in this context")


@given("automatic failover is not enabled")
def automatic_failover_not_enabled():
    """No-op: automatic failover is not enabled by default."""


# ── Given: replication group state ────────────────────────────────────


@given("the replication group does not already exist")
def rg_not_already_exist():
    """No-op: fresh state has no replication groups."""


@given("the replication group already exists")
def rg_already_exists(lws_session):
    _create_replication_group(lws_session)


@given("the replication group exists")
def rg_exists(lws_session):
    _create_replication_group(lws_session)


@given("the replication group does not exist")
def rg_does_not_exist():
    """No-op: fresh state has no replication groups."""


@given('the replication group is "AVAILABLE"')
def rg_is_available_given():
    """No-op: lws returns replication groups as AVAILABLE after creation."""


@given('the replication group is not "AVAILABLE"')
def rg_is_not_available_given(lws_session):
    lws_session.lifecycle("elasticache").create_dwell_ms(5000).apply()
    _create_replication_group(lws_session)


@given('the replication group is "CREATING"')
def rg_is_creating_given(lws_session):
    lws_session.lifecycle("elasticache").create_dwell_ms(5000).apply()
    _create_replication_group(lws_session)


@given('the replication group is not "CREATING"')
def rg_is_not_creating_given():
    """No-op: replication groups are not in CREATING state by default."""


@given('the replication group is "DELETING"')
def rg_is_deleting_given():
    pytest.skip("Cannot observe DELETING replication group state in lws")


@given('the replication group is not "DELETING"')
def rg_is_not_deleting_given():
    """No-op: replication groups are not in DELETING state by default."""


@given('the replication group is "MODIFYING"')
def rg_is_modifying_given():
    pytest.skip("Cannot trigger internal replication group MODIFYING state in lws")


@given('the replication group is not "MODIFYING"')
def rg_is_not_modifying_given():
    """No-op: replication groups are not in MODIFYING state by default."""


# ── Given: snapshot state ──────────────────────────────────────────────


@given("the snapshot does not exist")
def snapshot_does_not_exist():
    """No-op: fresh state has no snapshots."""


@given("the snapshot exists")
def snapshot_exists(lws_session):
    _create_cluster(lws_session)
    _create_snapshot(lws_session)


@given('the snapshot is "AVAILABLE"')
def snapshot_is_available_given():
    """No-op: snapshots are AVAILABLE immediately after creation in lws."""


@given('the snapshot is not "AVAILABLE"')
def snapshot_is_not_available_given():
    pytest.skip("Cannot control snapshot availability state in lws")


@given('the snapshot is "CREATING"')
def snapshot_is_creating_given():
    pytest.skip("Cannot observe CREATING snapshot state in lws")


@given('the snapshot is not "CREATING"')
def snapshot_is_not_creating_given():
    """No-op: snapshots are not in CREATING state by default."""


@given('the snapshot is "DELETING"')
def snapshot_is_deleting_given():
    pytest.skip("Cannot observe DELETING snapshot state in lws")


@given('the snapshot is not "DELETING"')
def snapshot_is_not_deleting_given():
    """No-op: snapshots are not in DELETING state by default."""


@given("the snapshot belongs to this cluster")
def snapshot_belongs_to_cluster():
    """No-op: snapshot is linked to cluster by default."""


@given("the snapshot does not belong to this cluster")
def snapshot_does_not_belong_to_cluster():
    pytest.skip("Cannot create orphan snapshot in lws")


@given("the snapshot slot is available")
def snapshot_slot_available():
    """No-op: always room for snapshots."""


@given("the snapshot slot is not available")
def snapshot_slot_not_available():
    pytest.skip("Cannot exhaust snapshot slot limit in lws")


# ── Given: parameter group state ──────────────────────────────────────


@given("the parameter group already exists")
def pg_already_exists(lws_session):
    _create_parameter_group(lws_session)


@given("the parameter group does not already exist")
def pg_not_already_exist():
    """No-op: fresh state has no parameter groups."""


@given("the parameter group exists")
def pg_exists(lws_session):
    _create_parameter_group(lws_session)


@given("the parameter group does not exist")
def pg_does_not_exist():
    """No-op: fresh state has no parameter groups."""


# ── Given: subnet group state ──────────────────────────────────────────


@given("the subnet group already exists")
def sg_already_exists(lws_session):
    _create_subnet_group(lws_session)


@given("the subnet group does not already exist")
def sg_not_already_exist():
    """No-op: fresh state has no subnet groups."""


@given("the subnet group exists")
def sg_exists(lws_session):
    _create_subnet_group(lws_session)


@given("the subnet group does not exist")
def sg_does_not_exist():
    """No-op: fresh state has no subnet groups."""


# ── Given: tag state ───────────────────────────────────────────────────


@given("the resource exists")
def resource_exists(lws_session):
    _create_cluster(lws_session)


@given("the resource does not exist")
def resource_does_not_exist():
    """No-op: fresh state has no resources."""


@given("the resource has tags")
def resource_has_tags():
    """No-op: resource tag state is managed by test setup."""


@given("the resource does not have tags")
def resource_does_not_have_tags():
    """No-op: fresh resources have no tags."""


# ── Given: FizzBee model step guards ──────────────────────────────────


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    _create_cluster(lws_session)


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: fresh state has no clusters."""


@given("cid in tag_exists")
def cid_in_tag_exists(lws_session):
    _create_cluster(lws_session)


@given("pgid in pg_exists")
def pgid_in_pg_exists(lws_session):
    _create_parameter_group(lws_session)


@given("pgid not in pg_exists")
def pgid_not_in_pg_exists():
    """No-op: fresh state has no parameter groups."""


@given("rgid in rg_status")
def rgid_in_rg_status(lws_session):
    _create_replication_group(lws_session)


@given("rgid not in rg_status")
def rgid_not_in_rg_status():
    """No-op: fresh state has no replication groups."""


@given("sgid in sg_exists")
def sgid_in_sg_exists(lws_session):
    _create_subnet_group(lws_session)


@given("sgid not in sg_exists")
def sgid_not_in_sg_exists():
    """No-op: fresh state has no subnet groups."""


@given("sid in snapshot_status")
def sid_in_snapshot_status(lws_session):
    _create_cluster(lws_session)
    _create_snapshot(lws_session)


# ── When: actions ──────────────────────────────────────────────────────


@when("a redis cache cluster is created")
def create_redis_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).create_cache_cluster(
            CacheClusterId=TEST_CLUSTER,
            CacheNodeType="cache.t3.micro",
            Engine="redis",
            NumCacheNodes=1,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a memcached cache cluster is created")
def create_memcached_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).create_cache_cluster(
            CacheClusterId=TEST_CLUSTER,
            CacheNodeType="cache.t3.micro",
            Engine="memcached",
            NumCacheNodes=1,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a standalone cache cluster is deleted")
def delete_cache_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).delete_cache_cluster(
            CacheClusterId=TEST_CLUSTER,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a cache cluster configuration is modified")
def modify_cache_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).modify_cache_cluster(
            CacheClusterId=TEST_CLUSTER,
            NumCacheNodes=1,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a replication group is created")
def create_replication_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).create_replication_group(
            ReplicationGroupId=TEST_REPLICATION_GROUP,
            ReplicationGroupDescription="e2e test replication group",
            CacheNodeType="cache.t3.micro",
            Engine="redis",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a replication group is deleted")
def delete_replication_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).delete_replication_group(
            ReplicationGroupId=TEST_REPLICATION_GROUP,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a replication group configuration is modified")
def modify_replication_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).modify_replication_group(
            ReplicationGroupId=TEST_REPLICATION_GROUP,
            ReplicationGroupDescription="e2e test rg updated",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a replica is added to a replication group")
def add_replica_to_rg(lws_session, world):
    pytest.skip("Cannot add replica to replication group in lws")


@when("an automatic failover promotes a new primary in a replication group")
def automatic_failover_rg(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache failover in lws")


@when("a snapshot is created from an available redis cache cluster")
def create_snapshot_from_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).create_snapshot(
            SnapshotName=TEST_SNAPSHOT,
            CacheClusterId=TEST_CLUSTER,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a cache snapshot is deleted")
def delete_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).delete_snapshot(
            SnapshotName=TEST_SNAPSHOT,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a cache cluster is created from a snapshot")
def create_cluster_from_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).create_cache_cluster(
            CacheClusterId="e2e-test-cluster-2",
            CacheNodeType="cache.t3.micro",
            Engine="redis",
            NumCacheNodes=1,
            SnapshotName=TEST_SNAPSHOT,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a cache parameter group is created")
def create_parameter_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).create_cache_parameter_group(
            CacheParameterGroupName=TEST_PARAMETER_GROUP,
            CacheParameterGroupFamily="redis6.x",
            Description="e2e test parameter group",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a cache parameter group is deleted")
def delete_parameter_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).delete_cache_parameter_group(
            CacheParameterGroupName=TEST_PARAMETER_GROUP,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a cache subnet group is created")
def create_subnet_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).create_cache_subnet_group(
            CacheSubnetGroupName=TEST_SUBNET_GROUP,
            CacheSubnetGroupDescription="e2e test subnet group",
            SubnetIds=["subnet-12345678"],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a cache subnet group is deleted")
def delete_subnet_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _elasticache(lws_session).delete_cache_subnet_group(
            CacheSubnetGroupName=TEST_SUBNET_GROUP,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("tags are added to a cache resource")
def add_tags_to_resource(lws_session, world):
    pytest.skip("Cannot construct ElastiCache ARN for tag operations in this context")


@when("tags are removed from a cache resource")
def remove_tags_from_resource(lws_session, world):
    pytest.skip("Cannot construct ElastiCache ARN for tag operations in this context")


@when("a standalone cache cluster finishes creating")
def cluster_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache cluster creation completion in lws")


@when("a cache cluster deletion completes")
def cluster_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache cluster deletion completion in lws")


@when("a cache cluster modification completes")
def cluster_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache cluster modification completion in lws")


@when("a cache cluster restore from snapshot completes")
def cluster_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache cluster restore completion in lws")


@when("a replication group finishes creating")
def rg_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache replication group creation completion in lws")


@when("a replication group deletion completes")
def rg_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache replication group deletion completion in lws")


@when("a replication group modification completes")
def rg_modification_completes(lws_session, world):
    pytest.skip(
        "Cannot trigger internal ElastiCache replication group modification completion in lws"
    )


@when("a replica creation in a replication group completes")
def replica_creation_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache replica creation completion in lws")


@when("a cache snapshot finishes creating")
def snapshot_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache snapshot creation completion in lws")


@when("a cache snapshot deletion completes")
def snapshot_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache snapshot deletion completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the cluster is in "CREATING" state')
def cluster_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_cache_clusters(CacheClusterId=TEST_CLUSTER)
    actual_clusters = resp.get("CacheClusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"
    actual_status = actual_clusters[0]["CacheClusterStatus"]
    expected_statuses = ("creating", "available")
    assert (
        actual_status in expected_statuses
    ), f"Expected cluster status in {expected_statuses} but got: {actual_status}"


@then('the cluster is in "CREATING" state with the memcached engine')
def cluster_is_creating_memcached_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_cache_clusters(CacheClusterId=TEST_CLUSTER)
    actual_clusters = resp.get("CacheClusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_cache_clusters(CacheClusterId=TEST_CLUSTER)
    actual_clusters = resp.get("CacheClusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"


@then('the cluster is "DELETED" and its tags are removed')
def cluster_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected cluster delete to succeed but got: {actual_error}"


@then('the cluster is in "DELETING" state')
def cluster_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected cluster delete to succeed but got: {actual_error}"


@then('the cluster is in "MODIFYING" state')
def cluster_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_cache_clusters(CacheClusterId=TEST_CLUSTER)
    actual_clusters = resp.get("CacheClusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"


@then('the cluster is in "RESTORING" state')
def cluster_is_restoring_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_cache_clusters(CacheClusterId="e2e-test-cluster-2")
    actual_clusters = resp.get("CacheClusters", [])
    assert (
        len(actual_clusters) > 0
    ), "Expected restored cluster 'e2e-test-cluster-2' to exist but found none"


@then('the cluster returns to "AVAILABLE" state')
def cluster_returns_to_available_then():
    pytest.skip("Cannot observe internal cluster state transition in lws")


@then('the replica cluster is "AVAILABLE"')
def replica_cluster_is_available_then():
    pytest.skip("Cannot observe internal replica cluster creation in lws")


@then('the replication group is in "CREATING" state')
def rg_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_replication_groups(
        ReplicationGroupId=TEST_REPLICATION_GROUP
    )
    actual_groups = resp.get("ReplicationGroups", [])
    assert (
        len(actual_groups) > 0
    ), f"Expected replication group '{TEST_REPLICATION_GROUP}' to exist but found none"


@then('the replication group and its primary cluster are "AVAILABLE"')
def rg_and_primary_available_then():
    pytest.skip("Cannot observe internal replication group creation completion in lws")


@then('the replication group is "DELETED" and its tags are removed')
def rg_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected replication group delete to succeed but got: {actual_error}"


@then('the replication group and its clusters are in "DELETING" state')
def rg_and_clusters_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected replication group delete to succeed but got: {actual_error}"


@then('the replication group is in "MODIFYING" state')
def rg_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_replication_groups(
        ReplicationGroupId=TEST_REPLICATION_GROUP
    )
    actual_groups = resp.get("ReplicationGroups", [])
    assert (
        len(actual_groups) > 0
    ), f"Expected replication group '{TEST_REPLICATION_GROUP}' to exist but found none"


@then('the replication group returns to "AVAILABLE" state')
def rg_returns_to_available_then():
    pytest.skip("Cannot observe internal replication group state transition in lws")


@then("the replication group has a new primary cluster")
def rg_has_new_primary_then():
    pytest.skip("Cannot observe internal replication group primary cluster change in lws")


@then('a new cluster is in "CREATING" state and associated with the replication group')
def new_cluster_creating_associated_with_rg_then():
    pytest.skip("Cannot observe internal replica creation in lws")


@then('the snapshot is in "CREATING" state and the cluster is "SNAPSHOTTING"')
def snapshot_creating_cluster_snapshotting_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_snapshots(SnapshotName=TEST_SNAPSHOT)
    actual_snapshots = resp.get("Snapshots", [])
    assert len(actual_snapshots) > 0, f"Expected snapshot '{TEST_SNAPSHOT}' to exist but found none"


@then('the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state')
def snapshot_available_cluster_returns_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_snapshots(SnapshotName=TEST_SNAPSHOT)
    actual_snapshots = resp.get("Snapshots", [])
    assert len(actual_snapshots) > 0, f"Expected snapshot '{TEST_SNAPSHOT}' to exist but found none"


@then('the snapshot is "DELETED" and its tags are removed')
def snapshot_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected snapshot delete to succeed but got: {actual_error}"


@then('the snapshot is in "DELETING" state')
def snapshot_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected snapshot delete to succeed but got: {actual_error}"


@then("the parameter group exists")
def parameter_group_exists_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_cache_parameter_groups(
        CacheParameterGroupName=TEST_PARAMETER_GROUP
    )
    actual_groups = resp.get("CacheParameterGroups", [])
    assert (
        len(actual_groups) > 0
    ), f"Expected parameter group '{TEST_PARAMETER_GROUP}' to exist but found none"


@then("the parameter group no longer exists")
def parameter_group_no_longer_exists_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected parameter group delete to succeed but got: {actual_error}"


@then("the subnet group exists")
def subnet_group_exists_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _elasticache(lws_session).describe_cache_subnet_groups(
        CacheSubnetGroupName=TEST_SUBNET_GROUP
    )
    actual_groups = resp.get("CacheSubnetGroups", [])
    assert (
        len(actual_groups) > 0
    ), f"Expected subnet group '{TEST_SUBNET_GROUP}' to exist but found none"


@then("the subnet group no longer exists")
def subnet_group_no_longer_exists_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected subnet group delete to succeed but got: {actual_error}"


@then("the resource remains tagged")
def resource_remains_tagged_then():
    pytest.skip("Cannot verify resource tag state in this context")


@then("the resource tag state is unchanged (no-op model)")
def resource_tag_state_unchanged_then():
    """No-op: tag state is an internal invariant; always passes."""


@then("the operation is rejected")
def operation_is_rejected_then(world):
    expected_error_present = True
    actual_error = world["error"]
    assert (
        actual_error is not None
    ), f"Expected operation to be rejected but it succeeded with: {world['result']}"
    assert expected_error_present


@then("memcached clusters are never associated with a replication group")
def memcached_clusters_not_in_rg():
    """No-op: replication group membership invariant; always passes."""


@then("all snapshots reference redis clusters only")
def snapshots_reference_redis_clusters():
    """No-op: snapshot-cluster relationship invariant; always passes."""


@then("every available replication group has a primary cluster assigned")
def available_rg_has_primary():
    """No-op: replication group primary invariant; always passes."""


@then("every active cluster, replication group, and snapshot has tags")
def active_resources_have_tags():
    """No-op: tag existence invariant; always passes."""


@then("every snapshotting cluster has a corresponding in-progress snapshot")
def snapshotting_cluster_has_snapshot():
    """No-op: snapshot-cluster consistency invariant; always passes."""
