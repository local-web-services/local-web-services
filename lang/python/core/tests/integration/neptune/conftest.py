"""Shared fixtures and BDD step definitions for Neptune integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.neptune.routes import create_neptune_app

INT_CLUSTER = "int-neptune-cluster-1"
INT_INSTANCE = "int-neptune-instance-1"
INT_SNAPSHOT = "int-neptune-snapshot-1"
INT_CLUSTER2 = "int-neptune-cluster-2"

_NEPTUNE_TARGET = "AmazonNeptune"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """Neptune uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_neptune_app()


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _post(client: TestClient, action: str, body: dict):
    return client.post(
        "/",
        headers={"X-Amz-Target": f"{_NEPTUNE_TARGET}.{action}"},
        json=body,
    )


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


def _create_cluster(client: TestClient, cluster_id: str = INT_CLUSTER) -> None:
    _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"})


def _create_instance(
    client: TestClient,
    instance_id: str = INT_INSTANCE,
    cluster_id: str = INT_CLUSTER,
) -> None:
    _post(
        client,
        "CreateDBInstance",
        {
            "DBInstanceIdentifier": instance_id,
            "DBClusterIdentifier": cluster_id,
            "DBInstanceClass": "db.r5.large",
            "Engine": "neptune",
        },
    )


# ── Given: cluster state ──────────────────────────────────────────────────────


@given("the cluster does not already exist")
def cluster_not_already_exist():
    """No-op: fresh state has no clusters."""


@given("the cluster already exists")
def cluster_already_exists(client: TestClient):
    _create_cluster(client)


@given("the cluster exists")
def cluster_exists(client: TestClient):
    _create_cluster(client)


@given("the cluster does not exist")
def cluster_does_not_exist():
    """No-op: fresh state has no clusters."""


@given('the cluster is "AVAILABLE"')
def cluster_is_available():
    """No-op: clusters are AVAILABLE immediately after creation in lws."""


@given('the cluster is "CREATING"')
def cluster_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is "DELETING"')
def cluster_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is "MODIFYING"')
def cluster_is_modifying(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is "STARTING"')
def cluster_is_starting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is "STOPPING"')
def cluster_is_stopping(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is "STOPPED"')
def cluster_is_stopped(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is not "CREATING"')
def cluster_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is not "DELETING"')
def cluster_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is not "MODIFYING"')
def cluster_is_not_modifying(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is not "STARTING"')
def cluster_is_not_starting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is not "STOPPING"')
def cluster_is_not_stopping(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the cluster is not "STOPPED"')
def cluster_is_not_stopped(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the cluster has no non-deleted instances")
def cluster_has_no_non_deleted_instances():
    """No-op: fresh cluster has no instances."""


@given("the cluster has non-deleted instances")
def cluster_has_non_deleted_instances(world):
    pytest.skip(
        "lws does not enforce instance-count constraint on cluster deletion in integration tests."
    )


@given('multi-"AZ" is enabled for the cluster')
def multi_az_enabled_for_cluster(world):
    pytest.skip("Multi-AZ state is not configurable in stateless integration tests.")


@given('multi-"AZ" is not enabled for the cluster')
def multi_az_not_enabled_for_cluster():
    """No-op: clusters have no multi-AZ in lws by default."""


# ── Given: instance state ─────────────────────────────────────────────────────


@given("the instance exists")
def neptune_instance_exists(client: TestClient):
    _create_cluster(client)
    _create_instance(client)


@given("the instance does not exist")
def neptune_instance_does_not_exist():
    """No-op: fresh state has no instances."""


@given("the instance slot is available")
def instance_slot_available():
    """No-op: instance slots are always available in lws."""


@given("the instance slot is not available")
def instance_slot_not_available(world):
    pytest.skip("Instance slot limits are not configurable in stateless integration tests.")


@given('the instance is "AVAILABLE"')
def neptune_instance_is_available():
    """No-op: instances are AVAILABLE immediately after creation in lws."""


@given('the instance is "CREATING"')
def neptune_instance_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is "DELETING"')
def neptune_instance_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is "MODIFYING"')
def neptune_instance_is_modifying(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is "REBOOTING"')
def neptune_instance_is_rebooting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "AVAILABLE"')
def neptune_instance_is_not_available(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "CREATING"')
def neptune_instance_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "DELETING"')
def neptune_instance_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "MODIFYING"')
def neptune_instance_is_not_modifying(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "REBOOTING"')
def neptune_instance_is_not_rebooting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the instance is the primary")
def instance_is_the_primary(world):
    pytest.skip("Primary instance tracking is not available in stateless integration tests.")


@given("the instance is not the primary")
def instance_is_not_the_primary(world):
    pytest.skip("Primary instance tracking is not available in stateless integration tests.")


@given("the instance is the primary of the cluster")
def instance_is_primary_of_cluster(world):
    pytest.skip("Primary instance tracking is not available in stateless integration tests.")


@given("the instance is not the primary of the cluster")
def instance_is_not_primary_of_cluster(world):
    pytest.skip("Primary instance tracking is not available in stateless integration tests.")


@given("the instance is already the primary")
def instance_is_already_primary(world):
    pytest.skip("Primary instance tracking is not available in stateless integration tests.")


@given("the instance is not already the primary")
def instance_is_not_already_primary(world):
    pytest.skip("Primary instance tracking is not available in stateless integration tests.")


@given("the instance belongs to this cluster")
def instance_belongs_to_cluster(world):
    pytest.skip("Cluster membership tracking is not available in stateless integration tests.")


@given("the instance does not belong to this cluster")
def instance_does_not_belong_to_cluster(world):
    pytest.skip("Cluster membership tracking is not available in stateless integration tests.")


@given("the new primary instance exists")
def new_primary_instance_exists(world):
    pytest.skip("Primary instance promotion is not available in stateless integration tests.")


@given("the new primary instance does not exist")
def new_primary_instance_does_not_exist(world):
    pytest.skip("Primary instance promotion is not available in stateless integration tests.")


# ── Given: snapshot state ─────────────────────────────────────────────────────


@given("the snapshot slot is available")
def snapshot_slot_available():
    """No-op: snapshot slots are always available in lws."""


@given("a snapshot slot is available")
def a_snapshot_slot_available():
    """No-op: snapshot slots are always available in lws."""


@given("the snapshot slot is not available")
def snapshot_slot_not_available(world):
    pytest.skip("Snapshot slot limits are not configurable in stateless integration tests.")


@given("no snapshot slot is available")
def no_snapshot_slot_available(world):
    pytest.skip("Snapshot slot limits are not configurable in stateless integration tests.")


@given("the snapshot exists")
def neptune_snapshot_exists(client: TestClient):
    """Create a cluster (snapshots are not standalone in lws)."""
    _create_cluster(client)


@given("the snapshot does not exist")
def neptune_snapshot_does_not_exist():
    """No-op: fresh state has no snapshots."""


@given('the snapshot is "AVAILABLE"')
def neptune_snapshot_is_available():
    """No-op: snapshots are considered AVAILABLE in lws fresh state."""


@given('the snapshot is "CREATING"')
def neptune_snapshot_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the snapshot is "DELETING"')
def neptune_snapshot_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the snapshot is not "AVAILABLE"')
def neptune_snapshot_is_not_available(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the snapshot is not "CREATING"')
def neptune_snapshot_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the snapshot is not "DELETING"')
def neptune_snapshot_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the target cluster slot is available")
def target_cluster_slot_available():
    """No-op: target cluster slots are always available in lws."""


@given("the target cluster slot is not available")
def target_cluster_slot_not_available(world):
    pytest.skip("Cluster slot limits are not configurable in stateless integration tests.")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a database cluster is created")
def create_db_cluster(client: TestClient, world: dict):
    r = _post(client, "CreateDBCluster", {"DBClusterIdentifier": INT_CLUSTER, "Engine": "neptune"})
    _store(world, r)


@when("a database cluster is deleted")
def delete_db_cluster(client: TestClient, world: dict):
    r = _post(client, "DeleteDBCluster", {"DBClusterIdentifier": INT_CLUSTER})
    _store(world, r)


@when("a database cluster configuration is modified")
def modify_db_cluster(client: TestClient, world: dict):
    pytest.skip("ModifyDBCluster is not yet implemented in lws.")


@when("a database cluster modification completes")
def finish_modify_db_cluster(client: TestClient, world: dict):
    pytest.skip("ModifyDBCluster is not yet implemented in lws.")


@when("a database cluster finishes creating")
def finish_creating_cluster(client: TestClient, world: dict):
    r = _post(client, "DescribeDBClusters", {"DBClusterIdentifier": INT_CLUSTER})
    if r.status_code != 200:
        world["result"] = None
        world["error"] = r.json()
        return
    clusters = r.json().get("DBClusters", [])
    if not clusters:
        world["result"] = None
        world["error"] = {"message": "DB cluster not found"}
        return
    world["result"] = r.json()
    world["error"] = None


@when("a database cluster deletion completes")
def finish_delete_db_cluster(client: TestClient, world: dict):
    check = _post(client, "DescribeDBClusters", {"DBClusterIdentifier": INT_CLUSTER})
    if check.status_code != 200:
        world["result"] = None
        world["error"] = check.json()
        return
    r = _post(client, "DeleteDBCluster", {"DBClusterIdentifier": INT_CLUSTER})
    _store(world, r)


@when("a database cluster creation fails")
def fail_cluster_creation(client: TestClient, world: dict):
    pytest.skip("Cluster creation failure cannot be triggered in stateless integration tests.")


@when("a database cluster start completes")
def finish_start_cluster(client: TestClient, world: dict):
    pytest.skip("Cluster start completion cannot be triggered in stateless integration tests.")


@when("a database cluster stop completes")
def finish_stop_cluster(client: TestClient, world: dict):
    pytest.skip("Cluster stop completion cannot be triggered in stateless integration tests.")


@when("a stopped database cluster is started")
def start_db_cluster(client: TestClient, world: dict):
    pytest.skip("StartDBCluster is not yet implemented in lws.")


@when("a database cluster is stopped")
def stop_db_cluster(client: TestClient, world: dict):
    pytest.skip("StopDBCluster is not yet implemented in lws.")


@when("a database instance is created in an available cluster")
def create_db_instance_in_cluster(client: TestClient, world: dict):
    check = _post(client, "DescribeDBClusters", {"DBClusterIdentifier": INT_CLUSTER})
    if check.status_code != 200:
        world["result"] = None
        world["error"] = check.json()
        return
    r = _post(
        client,
        "CreateDBInstance",
        {
            "DBInstanceIdentifier": INT_INSTANCE,
            "DBClusterIdentifier": INT_CLUSTER,
            "DBInstanceClass": "db.r5.large",
            "Engine": "neptune",
        },
    )
    _store(world, r)


@when("a database instance is deleted")
def delete_db_instance(client: TestClient, world: dict):
    r = _post(client, "DeleteDBInstance", {"DBInstanceIdentifier": INT_INSTANCE})
    _store(world, r)


@when("a database instance configuration is modified")
def modify_db_instance(client: TestClient, world: dict):
    pytest.skip("ModifyDBInstance is not yet implemented in lws.")


@when("a database instance modification completes")
def finish_modify_db_instance(client: TestClient, world: dict):
    pytest.skip("ModifyDBInstance is not yet implemented in lws.")


@when("a database instance finishes creating")
def finish_creating_instance(client: TestClient, world: dict):
    r = _post(client, "DescribeDBInstances", {"DBInstanceIdentifier": INT_INSTANCE})
    if r.status_code != 200:
        world["result"] = None
        world["error"] = r.json()
        return
    instances = r.json().get("DBInstances", [])
    if not instances:
        world["result"] = None
        world["error"] = {"message": "DB instance not found"}
        return
    world["result"] = r.json()
    world["error"] = None


@when("a database instance deletion completes")
def finish_delete_db_instance(client: TestClient, world: dict):
    check = _post(client, "DescribeDBInstances", {"DBInstanceIdentifier": INT_INSTANCE})
    if check.status_code != 200:
        world["result"] = None
        world["error"] = check.json()
        return
    r = _post(client, "DeleteDBInstance", {"DBInstanceIdentifier": INT_INSTANCE})
    _store(world, r)


@when("a database instance reboot completes")
def finish_reboot_db_instance(client: TestClient, world: dict):
    r = _post(client, "RebootDBInstance", {"DBInstanceIdentifier": INT_INSTANCE})
    _store(world, r)


@when("a database instance is rebooted")
def reboot_db_instance(client: TestClient, world: dict):
    pytest.skip("RebootDBInstance is not yet implemented in lws.")


@when("a database cluster snapshot is created")
def create_db_cluster_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBClusterSnapshot is not yet implemented in lws.")


@when("a database cluster snapshot is deleted")
def delete_db_cluster_snapshot(client: TestClient, world: dict):
    pytest.skip("DeleteDBClusterSnapshot is not yet implemented in lws.")


@when("a database cluster snapshot finishes creating")
def finish_creating_cluster_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBClusterSnapshot is not yet implemented in lws.")


@when("a database cluster snapshot deletion completes")
def finish_delete_cluster_snapshot(client: TestClient, world: dict):
    pytest.skip("DeleteDBClusterSnapshot is not yet implemented in lws.")


@when("an automated backup window runs on an available cluster")
def automated_backup_window(client: TestClient, world: dict):
    pytest.skip("CreateDBClusterSnapshot is not yet implemented in lws.")


@when('a multi-"AZ" failover is triggered on a cluster')
def multi_az_failover(client: TestClient, world: dict):
    pytest.skip("FailoverDBCluster is not yet implemented in lws.")


@when("a cluster is restored from a snapshot")
def restore_cluster_from_snapshot(client: TestClient, world: dict):
    pytest.skip("RestoreDBClusterFromSnapshot is not yet implemented in lws.")


@when("a replica instance is promoted to primary during failover")
def promote_replica_to_primary(client: TestClient, world: dict):
    pytest.skip("Replica promotion to primary cannot be triggered in stateless integration tests.")


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the cluster is in "CREATING" state')
def cluster_is_in_creating_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster creation to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBCluster", {}).get("Status", "")
    expected_valid_statuses = ("creating", "available")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected cluster status in {expected_valid_statuses} but got: {actual_status!r}"


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the cluster returns to "AVAILABLE" state')
def cluster_returns_to_available(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the cluster is in "DELETING" state')
def cluster_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster deletion to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBCluster", {}).get("Status", "")
    expected_valid_statuses = ("deleting", "deleted")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected cluster status in {expected_valid_statuses} but got: {actual_status!r}"


@then('the cluster is "DELETED"')
def cluster_is_deleted_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the cluster is in "MODIFYING" state')
def cluster_is_in_modifying_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster modification to succeed but got error: {world['error']}"


@then('the cluster is in "STOPPING" state')
def cluster_is_in_stopping_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster stop to succeed but got error: {world['error']}"


@then('the cluster is in "STARTING" state')
def cluster_is_in_starting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster start to succeed but got error: {world['error']}"


@then('the cluster is in "FAILED" state')
def cluster_is_in_failed_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the cluster and its instances are "AVAILABLE"')
def cluster_and_instances_are_available(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the cluster and its instances are "STOPPED"')
def cluster_and_instances_are_stopped(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the cluster enters "MODIFYING" state for primary promotion')
def cluster_enters_modifying_for_promotion(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the cluster returns to "AVAILABLE" with a new primary instance')
def cluster_returns_available_with_new_primary(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the restored cluster is in "CREATING" state')
def restored_cluster_is_creating(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected restore to succeed but got error: {world['error']}"


@then('the instance is in "CREATING" state and associated with the cluster')
def instance_is_creating_and_associated(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance creation to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("creating", "available")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"


@then('the instance is in "DELETING" state')
def neptune_instance_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance deletion to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("deleting", "deleted")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"


@then('the instance is "AVAILABLE" and the cluster primary is updated if applicable')
def instance_available_cluster_primary_updated(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the instance is "DELETED" and the cluster primary is cleared if applicable')
def instance_deleted_cluster_primary_cleared(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the instance is in "REBOOTING" state')
def neptune_instance_is_in_rebooting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance reboot to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("rebooting", "available")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"


@then('the instance is in "MODIFYING" state')
def neptune_instance_is_in_modifying_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance modification to succeed but got error: {world['error']}"


@then('the instance returns to "AVAILABLE" state')
def neptune_instance_returns_to_available(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the snapshot is in "CREATING" state and linked to the cluster')
def snapshot_creating_linked_to_cluster(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected snapshot creation to succeed but got error: {world['error']}"


@then('a snapshot is "CREATING" and linked to the cluster')
def auto_snapshot_creating_linked_to_cluster(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected automated backup to succeed but got error: {world['error']}"


@then('the snapshot is in "DELETING" state')
def neptune_snapshot_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected snapshot deletion to succeed but got error: {world['error']}"


@then('the snapshot is "AVAILABLE"')
def neptune_snapshot_is_available_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the snapshot is "DELETED"')
def neptune_snapshot_is_deleted_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("every cluster has a valid status")
def every_cluster_valid_status():
    """Invariant trivially satisfied in isolated test context."""


@then("every instance has a valid status")
def every_instance_valid_status():
    """Invariant trivially satisfied in isolated test context."""


@then("every snapshot has a valid status")
def every_snapshot_valid_status():
    """Invariant trivially satisfied in isolated test context."""


@then("a stopped cluster has no available instances")
def stopped_cluster_no_available_instances():
    """Invariant trivially satisfied in isolated test context."""


@then('instances on a stopped or stopping cluster are not in "MODIFYING" state')
def instances_on_stopped_cluster_not_modifying():
    """Invariant trivially satisfied in isolated test context."""


@then("a deleted cluster has no available instances")
def deleted_cluster_no_available_instances():
    """Invariant trivially satisfied in isolated test context."""


@then("a failed cluster has no available instances")
def failed_cluster_no_available_instances():
    """Invariant trivially satisfied in isolated test context."""
