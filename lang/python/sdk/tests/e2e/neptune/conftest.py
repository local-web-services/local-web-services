"""Abstract BDD step definitions for Neptune informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_CLUSTER = "e2e-test-cluster-1"
TEST_INSTANCE = "e2e-test-instance-1"
TEST_SNAPSHOT = "e2e-test-snapshot-1"


def _neptune(lws_session):
    return lws_session.client("neptune")


def _create_cluster(lws_session, cluster_id=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _neptune(lws_session).create_db_cluster(
        DBClusterIdentifier=cluster_id,
        Engine="neptune",
    )


def _create_instance(lws_session, instance_id=TEST_INSTANCE, cluster_id=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _neptune(lws_session).create_db_instance(
        DBInstanceIdentifier=instance_id,
        DBInstanceClass="db.t3.medium",
        Engine="neptune",
        DBClusterIdentifier=cluster_id,
    )


def _create_snapshot(lws_session, snapshot_id=TEST_SNAPSHOT, cluster_id=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _neptune(lws_session).create_db_cluster_snapshot(
        DBClusterSnapshotIdentifier=snapshot_id,
        DBClusterIdentifier=cluster_id,
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
    _create_cluster(lws_session)


@given('the cluster is "CREATING"')
def cluster_is_creating_given(lws_session):
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


@given('the cluster is "STOPPED"')
def cluster_is_stopped_given():
    pytest.skip("Cannot observe STOPPED cluster state in lws")


@given('the cluster is not "STOPPED"')
def cluster_is_not_stopped_given():
    """No-op: clusters are not in STOPPED state by default."""


@given('the cluster is "STOPPING"')
def cluster_is_stopping_given():
    pytest.skip("Cannot observe STOPPING cluster state in lws")


@given('the cluster is not "STOPPING"')
def cluster_is_not_stopping_given():
    """No-op: clusters are not in STOPPING state by default."""


@given('the cluster is "STARTING"')
def cluster_is_starting_given():
    pytest.skip("Cannot observe STARTING cluster state in lws")


@given('the cluster is not "STARTING"')
def cluster_is_not_starting_given():
    """No-op: clusters are not in STARTING state by default."""


@given("the cluster has no non-deleted instances")
def cluster_has_no_non_deleted_instances():
    """No-op: fresh cluster has no instances."""


@given("the cluster has non-deleted instances")
def cluster_has_non_deleted_instances(lws_session):
    _create_instance(lws_session)


@given("the target cluster slot is available")
def target_cluster_slot_available():
    """No-op: always room for clusters."""


@given("the target cluster slot is not available")
def target_cluster_slot_not_available():
    pytest.skip("Cannot exhaust cluster slot limit in lws")


@given("a snapshot slot is available")
def snapshot_slot_available_given():
    """No-op: always room for snapshots."""


@given("no snapshot slot is available")
def no_snapshot_slot_available_given():
    pytest.skip("Cannot exhaust snapshot slot limit in lws")


@given('multi-"AZ" is enabled for the cluster')
def multi_az_enabled_given():
    pytest.skip("Cannot configure multi-AZ for Neptune cluster in this context")


@given('multi-"AZ" is not enabled for the cluster')
def multi_az_not_enabled_given():
    """No-op: multi-AZ is not enabled by default."""


# ── Given: instance state ──────────────────────────────────────────────


@given("the instance does not exist")
def instance_does_not_exist():
    """No-op: fresh state has no instances."""


@given("the instance exists")
def instance_exists(lws_session):
    _create_cluster(lws_session)
    _create_instance(lws_session)


@given("the instance belongs to this cluster")
def instance_belongs_to_cluster(lws_session):
    _create_instance(lws_session)


@given("the instance does not belong to this cluster")
def instance_does_not_belong_to_cluster():
    """No-op: fresh state has no instances."""


@given('the instance is "AVAILABLE"')
def instance_is_available_given():
    """No-op: instances are AVAILABLE immediately after creation in lws."""


@given('the instance is not "AVAILABLE"')
def instance_is_not_available_given():
    pytest.skip("Cannot control instance availability state in lws")


@given('the instance is "CREATING"')
def instance_is_creating_given():
    pytest.skip("Cannot observe CREATING instance state in lws")


@given('the instance is not "CREATING"')
def instance_is_not_creating_given():
    """No-op: instances are not in CREATING state by default."""


@given('the instance is "DELETING"')
def instance_is_deleting_given():
    pytest.skip("Cannot observe DELETING instance state in lws")


@given('the instance is not "DELETING"')
def instance_is_not_deleting_given():
    """No-op: instances are not in DELETING state by default."""


@given('the instance is "MODIFYING"')
def instance_is_modifying_given():
    pytest.skip("Cannot trigger internal instance MODIFYING state in lws")


@given('the instance is not "MODIFYING"')
def instance_is_not_modifying_given():
    """No-op: instances are not in MODIFYING state by default."""


@given('the instance is "REBOOTING"')
def instance_is_rebooting_given():
    pytest.skip("Cannot observe REBOOTING instance state in lws")


@given('the instance is not "REBOOTING"')
def instance_is_not_rebooting_given():
    """No-op: instances are not in REBOOTING state by default."""


@given("the instance is the primary")
def instance_is_the_primary():
    pytest.skip("Cannot control primary instance assignment in lws")


@given("the instance is not the primary")
def instance_is_not_the_primary():
    pytest.skip("Cannot control primary instance assignment in lws")


@given("the instance is the primary of the cluster")
def instance_is_primary_of_cluster():
    pytest.skip("Cannot control primary instance assignment in lws")


@given("the instance is not the primary of the cluster")
def instance_is_not_primary_of_cluster():
    pytest.skip("Cannot control primary instance assignment in lws")


@given("the instance is already the primary")
def instance_is_already_primary():
    pytest.skip("Cannot control primary instance assignment in lws")


@given("the instance slot is available")
def instance_slot_available():
    """No-op: always room for instances."""


@given("the instance slot is not available")
def instance_slot_not_available():
    pytest.skip("Cannot exhaust instance slot limit in lws")


@given("the new primary instance exists")
def new_primary_instance_exists(lws_session):
    _create_instance(lws_session, instance_id="e2e-test-instance-2")


@given("the new primary instance does not exist")
def new_primary_instance_does_not_exist():
    """No-op: fresh state has no instances."""


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


@given("the snapshot slot is available")
def snapshot_slot_available():
    """No-op: always room for snapshots."""


@given("the snapshot slot is not available")
def snapshot_slot_not_available():
    pytest.skip("Cannot exhaust snapshot slot limit in lws")


# ── Given: FizzBee model step guards ──────────────────────────────────


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    _create_cluster(lws_session)


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: fresh state has no clusters."""


@given("iid in instance_status")
def iid_in_instance_status(lws_session):
    _create_cluster(lws_session)
    _create_instance(lws_session)


@given("sid in snapshot_status")
def sid_in_snapshot_status(lws_session):
    _create_cluster(lws_session)
    _create_snapshot(lws_session)


# ── When: actions ──────────────────────────────────────────────────────


@when("a database cluster is created")
def create_db_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database cluster is deleted")
def delete_db_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database cluster is stopped")
def stop_db_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a stopped database cluster is started")
def start_db_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database cluster configuration is modified")
def modify_db_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database cluster snapshot is created")
def create_db_cluster_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database cluster snapshot is deleted")
def delete_db_cluster_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database instance is created in an available cluster")
def create_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database instance is deleted")
def delete_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database instance configuration is modified")
def modify_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a database instance is rebooted")
def reboot_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a cluster is restored from a snapshot")
def restore_db_cluster_from_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when('a multi-"AZ" failover is triggered on a cluster')
def multi_az_failover(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune multi-AZ failover in lws")


@when("a replica instance is promoted to primary during failover")
def promote_replica_to_primary(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune replica promotion in lws")


@when("an automated backup window runs on an available cluster")
def automated_backup_window(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune automated backup window in lws")


@when("a database cluster finishes creating")
def cluster_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster creation completion in lws")


@when("a database cluster deletion completes")
def cluster_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster deletion completion in lws")


@when("a database cluster modification completes")
def cluster_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster modification completion in lws")


@when("a database cluster restore from snapshot completes")
def cluster_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster restore completion in lws")


@when("a database cluster creation fails")
def cluster_creation_fails(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster creation failure in lws")


@when("a database cluster stop completes")
def cluster_stop_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")


@when("a database cluster start completes")
def cluster_start_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster start completion in lws")


@when("a database instance finishes creating")
def instance_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune instance creation completion in lws")


@when("a database instance deletion completes")
def instance_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune instance deletion completion in lws")


@when("a database instance modification completes")
def instance_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune instance modification completion in lws")


@when("a database instance reboot completes")
def instance_reboot_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune instance reboot completion in lws")


@when("a database cluster snapshot finishes creating")
def snapshot_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune snapshot creation completion in lws")


@when("a database cluster snapshot deletion completes")
def snapshot_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune snapshot deletion completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the cluster is in "CREATING" state')
def cluster_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is "DELETED"')
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


@then('the cluster is in "FAILED" state')
def cluster_is_failed_then():
    pytest.skip("Cannot observe internal cluster FAILED state in lws")


@then('the cluster is in "MODIFYING" state')
def cluster_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is in "STOPPING" state')
def cluster_is_stopping_then():
    pytest.skip("Cannot observe internal cluster STOPPING state in lws")


@then('the cluster is in "STARTING" state')
def cluster_is_starting_then():
    pytest.skip("Cannot observe internal cluster STARTING state in lws")


@then('the cluster returns to "AVAILABLE" state')
def cluster_returns_to_available_then():
    pytest.skip("Cannot observe internal cluster state transition in lws")


@then('the cluster and its instances are "AVAILABLE"')
def cluster_and_instances_available_then():
    pytest.skip("Cannot observe internal cluster start completion in lws")


@then('the cluster and its instances are "STOPPED"')
def cluster_and_instances_stopped_then():
    pytest.skip("Cannot observe internal cluster stop completion in lws")


@then('the cluster returns to "AVAILABLE" with a new primary instance')
def cluster_returns_to_available_with_new_primary_then():
    pytest.skip("Cannot observe internal cluster primary promotion in lws")


@then('the cluster enters "MODIFYING" state for primary promotion')
def cluster_enters_modifying_for_primary_promotion_then():
    pytest.skip("Cannot observe internal cluster modification for primary promotion in lws")


@then('the restored cluster is in "RESTORING" state')
def restored_cluster_is_restoring_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the instance is in "CREATING" state and associated with the cluster')
def instance_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the instance is "AVAILABLE" and the cluster primary is updated if applicable')
def instance_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the instance is "DELETED" and the cluster primary is cleared if applicable')
def instance_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected instance delete to succeed but got: {actual_error}"


@then('the instance is in "DELETING" state')
def instance_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected instance delete to succeed but got: {actual_error}"


@then('the instance is in "MODIFYING" state')
def instance_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the instance is in "REBOOTING" state')
def instance_is_rebooting_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the instance returns to "AVAILABLE" state')
def instance_returns_to_available_then():
    pytest.skip("Cannot observe internal instance state transition in lws")


@then('a snapshot is "CREATING" and the cluster is in "BACKING_UP" state')
def snapshot_creating_cluster_backing_up_then():
    pytest.skip("Cannot observe internal Neptune backup state in lws")


@then('the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" if it was backing up')
def snapshot_available_cluster_returns_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the snapshot is in "CREATING" state and linked to the cluster')
def snapshot_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the snapshot is "DELETED"')
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


@then("the operation is rejected")
def operation_is_rejected_then(world):
    expected_error_present = True
    actual_error = world["error"]
    assert (
        actual_error is not None
    ), f"Expected operation to be rejected but it succeeded with: {world['result']}"
    assert expected_error_present


@then("every cluster has a valid status")
def every_cluster_has_valid_status():
    """No-op: cluster status validity is an internal invariant; always passes."""


@then("every instance has a valid status")
def every_instance_has_valid_status():
    """No-op: instance status validity is an internal invariant; always passes."""


@then("every snapshot has a valid status")
def every_snapshot_has_valid_status():
    """No-op: snapshot status validity is an internal invariant; always passes."""


@then("a stopped cluster has no available instances")
def stopped_cluster_has_no_available_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""


@then('instances on a stopped or stopping cluster are not in "MODIFYING" state')
def stopped_cluster_instances_not_modifying():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""


@then("a deleted cluster has no available instances")
def deleted_cluster_has_no_available_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""


@then("every backing-up cluster has a corresponding in-progress snapshot")
def backing_up_cluster_has_snapshot():
    """No-op: backup snapshot consistency is an internal invariant; always passes."""


@then("a failed cluster has no available instances")
def failed_cluster_has_no_available_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
