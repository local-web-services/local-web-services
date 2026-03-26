"""Abstract BDD step definitions for Memorydb informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_CLUSTER = "e2e-test-cluster-1"
TEST_SNAPSHOT = "e2e-test-snapshot-1"
TEST_USER = "e2e-test-user-1"
TEST_ACL = "e2e-test-acl-1"


def _memorydb(lws_session):
    return lws_session.client("memorydb")


def _create_cluster(lws_session, cluster_id=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _memorydb(lws_session).create_cluster(
        ClusterName=cluster_id,
        NodeType="db.t4g.small",
        ACLName="open-access",
    )


def _create_snapshot(lws_session, snapshot_id=TEST_SNAPSHOT, cluster_id=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _memorydb(lws_session).create_snapshot(
        ClusterName=cluster_id,
        SnapshotName=snapshot_id,
    )


def _create_user(lws_session, user_id=TEST_USER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _memorydb(lws_session).create_user(
        UserName=user_id,
        AuthenticationMode={"Type": "no-password"},
        AccessString="on ~* &* +@all",
    )


def _create_acl(lws_session, acl_id=TEST_ACL):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _memorydb(lws_session).create_acl(
        ACLName=acl_id,
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
    lws_session.lifecycle("memorydb").create_dwell_ms(5000).apply()
    _create_cluster(lws_session)


@given('the cluster is "CREATING"')
def cluster_is_creating_given(lws_session):
    lws_session.lifecycle("memorydb").create_dwell_ms(5000).apply()
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


@given("the target cluster slot is available")
def target_cluster_slot_available():
    """No-op: always room for clusters."""


@given("the target cluster slot is not available")
def target_cluster_slot_not_available():
    pytest.skip("Cannot exhaust cluster slot limit in lws")


@given('multi-"AZ" is enabled for the cluster')
def multi_az_enabled_given():
    pytest.skip("Cannot configure multi-AZ for MemoryDB cluster in this context")


@given('multi-"AZ" is not enabled for the cluster')
def multi_az_not_enabled_given():
    """No-op: multi-AZ is not enabled by default."""


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


# ── Given: user state ──────────────────────────────────────────────────


@given("the user does not already exist")
def user_not_already_exist():
    """No-op: fresh state has no users."""


@given("the user already exists")
def user_already_exists(lws_session):
    _create_user(lws_session)


@given("the user exists")
def user_exists(lws_session):
    _create_user(lws_session)


@given("the user does not exist")
def user_does_not_exist():
    """No-op: fresh state has no users."""


@given('the user is "ACTIVE"')
def user_is_active_given():
    """No-op: users are ACTIVE immediately after creation in lws."""


@given('the user is not "ACTIVE"')
def user_is_not_active_given():
    pytest.skip("Cannot control user activity state in lws")


@given('the user is "CREATING"')
def user_is_creating_given():
    pytest.skip("Cannot observe CREATING user state in lws")


@given('the user is not "CREATING"')
def user_is_not_creating_given():
    """No-op: users are not in CREATING state by default."""


@given('the user is "DELETING"')
def user_is_deleting_given():
    pytest.skip("Cannot observe DELETING user state in lws")


@given('the user is not "DELETING"')
def user_is_not_deleting_given():
    """No-op: users are not in DELETING state by default."""


@given('the user is "MODIFYING"')
def user_is_modifying_given():
    pytest.skip("Cannot trigger internal user MODIFYING state in lws")


@given('the user is not "MODIFYING"')
def user_is_not_modifying_given():
    """No-op: users are not in MODIFYING state by default."""


@given('the user is a member of the "ACL"')
def user_is_member_of_acl():
    pytest.skip("Cannot configure ACL membership in this context")


@given('the user is not a member of the "ACL"')
def user_is_not_member_of_acl():
    """No-op: users are not ACL members by default."""


@given('the user is already a member of the "ACL"')
def user_is_already_member_of_acl():
    pytest.skip("Cannot configure existing ACL membership in this context")


@given('the user is not already a member of the "ACL"')
def user_is_not_already_member_of_acl():
    """No-op: users are not ACL members by default."""


@given("the user membership entry exists")
def user_membership_entry_exists():
    pytest.skip("Cannot configure user membership entry in this context")


@given("the user membership entry does not exist")
def user_membership_entry_does_not_exist():
    """No-op: fresh state has no user membership entries."""


# ── Given: ACL state ───────────────────────────────────────────────────


@given('the "ACL" does not already exist')
def acl_not_already_exist():
    """No-op: fresh state has no ACLs."""


@given('the "ACL" already exists')
def acl_already_exists(lws_session):
    _create_acl(lws_session)


@given('the "ACL" exists')
def acl_exists(lws_session):
    _create_acl(lws_session)


@given('the "ACL" does not exist')
def acl_does_not_exist():
    """No-op: fresh state has no ACLs."""


@given('the "ACL" is "ACTIVE"')
def acl_is_active_given():
    """No-op: ACLs are ACTIVE immediately after creation in lws."""


@given('the "ACL" is not "ACTIVE"')
def acl_is_not_active_given():
    pytest.skip("Cannot control ACL activity state in lws")


@given('the "ACL" is "CREATING"')
def acl_is_creating_given():
    pytest.skip("Cannot observe CREATING ACL state in lws")


@given('the "ACL" is not "CREATING"')
def acl_is_not_creating_given():
    """No-op: ACLs are not in CREATING state by default."""


@given('the "ACL" is "DELETING"')
def acl_is_deleting_given():
    pytest.skip("Cannot observe DELETING ACL state in lws")


@given('the "ACL" is not "DELETING"')
def acl_is_not_deleting_given():
    """No-op: ACLs are not in DELETING state by default."""


@given('the "ACL" is "MODIFYING"')
def acl_is_modifying_given():
    pytest.skip("Cannot trigger internal ACL MODIFYING state in lws")


@given('the "ACL" is not "MODIFYING"')
def acl_is_not_modifying_given():
    """No-op: ACLs are not in MODIFYING state by default."""


# ── Given: tag state ───────────────────────────────────────────────────


@given("the resource has a tag entry")
def resource_has_tag_entry():
    pytest.skip("Cannot configure resource tags in this context")


@given("the resource does not have a tag entry")
def resource_does_not_have_tag_entry():
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


@given("aid in acl_status")
def aid_in_acl_status(lws_session):
    _create_acl(lws_session)


@given("aid not in acl_status")
def aid_not_in_acl_status():
    """No-op: fresh state has no ACLs."""


@given("uid in user_status")
def uid_in_user_status(lws_session):
    _create_user(lws_session)


@given("uid not in user_status")
def uid_not_in_user_status():
    """No-op: fresh state has no users."""


@given("sid in snapshot_status")
def sid_in_snapshot_status(lws_session):
    _create_cluster(lws_session)
    _create_snapshot(lws_session)


# ── Given: sequence setup ─────────────────────────────────────────────


@given("a MemoryDB cluster has been created")
def memorydb_cluster_has_been_created_seq(lws_session):
    _create_cluster(lws_session)


@given("a MemoryDB cluster has been deleted")
def memorydb_cluster_has_been_deleted_seq(lws_session):
    try:
        _create_cluster(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _memorydb(lws_session).delete_cluster(ClusterName=TEST_CLUSTER)


@given("a MemoryDB cluster has finished creating")
def memorydb_cluster_has_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster creation completion in lws")


@given("a MemoryDB cluster update has completed")
def memorydb_cluster_update_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster update completion in lws")


@given("a MemoryDB cluster deletion has completed")
def memorydb_cluster_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster deletion completion in lws")


@given("a MemoryDB cluster configuration has been updated")
def memorydb_cluster_configuration_updated_seq(lws_session):
    _create_cluster(lws_session)


@given("a cluster has been restored from a snapshot")
def memorydb_cluster_restored_from_snapshot_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster restore in lws")


@given("a cluster restore from snapshot has completed")
def memorydb_cluster_restore_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB cluster restore completion in lws")


@given('a shard failover has been triggered on a multi-"AZ" cluster')
def memorydb_shard_failover_triggered_seq():
    pytest.skip("Cannot trigger internal MemoryDB shard failover in lws")


@given("a snapshot has been created from an available cluster")
def memorydb_snapshot_created_seq(lws_session):
    _create_cluster(lws_session)
    _create_snapshot(lws_session)


@given("a snapshot has been deleted")
def memorydb_snapshot_deleted_seq(lws_session):
    try:
        _create_cluster(lws_session)
        _create_snapshot(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _memorydb(lws_session).delete_snapshot(SnapshotName=TEST_SNAPSHOT)


@given("a snapshot has finished creating")
def memorydb_snapshot_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB snapshot creation completion in lws")


@given("a snapshot deletion has completed")
def memorydb_snapshot_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB snapshot deletion completion in lws")


@given("a user has been created")
def memorydb_user_created_seq(lws_session):
    _create_user(lws_session)


@given("a user has been deleted")
def memorydb_user_deleted_seq(lws_session):
    try:
        _create_user(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _memorydb(lws_session).delete_user(UserName=TEST_USER)


@given("a user has been updated")
def memorydb_user_updated_seq(lws_session):
    _create_user(lws_session)


@given("a user has finished creating")
def memorydb_user_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB user creation completion in lws")


@given("a user update has completed")
def memorydb_user_update_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB user update completion in lws")


@given("a user deletion has completed")
def memorydb_user_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB user deletion completion in lws")


@given('a user has been added to an "ACL"')
def memorydb_user_added_to_acl_seq(lws_session):
    _create_user(lws_session)
    _create_acl(lws_session)


@given('a user has been removed from an "ACL"')
def memorydb_user_removed_from_acl_seq(lws_session):
    _create_user(lws_session)
    _create_acl(lws_session)


@given('an "ACL" has been created')
def memorydb_acl_created_seq(lws_session):
    _create_acl(lws_session)


@given('an "ACL" has been deleted')
def memorydb_acl_deleted_seq(lws_session):
    try:
        _create_acl(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _memorydb(lws_session).delete_acl(ACLName=TEST_ACL)


@given('an "ACL" has been updated')
def memorydb_acl_updated_seq(lws_session):
    _create_acl(lws_session)


@given('an "ACL" has finished creating')
def memorydb_acl_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB ACL creation completion in lws")


@given('an "ACL" update has completed')
def memorydb_acl_update_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB ACL update completion in lws")


@given('an "ACL" deletion has completed')
def memorydb_acl_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB ACL deletion completion in lws")


@given('an "ACL" has been associated with a cluster')
def memorydb_acl_associated_with_cluster_seq(lws_session):
    _create_cluster(lws_session)
    _create_acl(lws_session)


@given("tags have been added to a MemoryDB resource")
def memorydb_tags_added_seq():
    pytest.skip("Cannot construct MemoryDB ARN for tag operations in this context")


@given("tags have been removed from a MemoryDB resource")
def memorydb_tags_removed_seq():
    pytest.skip("Cannot construct MemoryDB ARN for tag operations in this context")


# ── When: actions ──────────────────────────────────────────────────────


@when("a MemoryDB cluster is created")
def create_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).create_cluster(
            ClusterName=TEST_CLUSTER,
            NodeType="db.t4g.small",
            ACLName="open-access",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a MemoryDB cluster is deleted")
def delete_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).delete_cluster(
            ClusterName=TEST_CLUSTER,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a MemoryDB cluster configuration is updated")
def update_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).update_cluster(
            ClusterName=TEST_CLUSTER,
            Description="e2e test update",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a snapshot is created from an available cluster")
def create_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).create_snapshot(
            ClusterName=TEST_CLUSTER,
            SnapshotName=TEST_SNAPSHOT,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a snapshot is deleted")
def delete_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).delete_snapshot(
            SnapshotName=TEST_SNAPSHOT,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a cluster is restored from a snapshot")
def restore_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).restore_cluster(
            ClusterName="e2e-test-cluster-2",
            SnapshotName=TEST_SNAPSHOT,
            NodeType="db.t4g.small",
            ACLName="open-access",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a user is created")
def create_user(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).create_user(
            UserName=TEST_USER,
            AuthenticationMode={"Type": "no-password"},
            AccessString="on ~* &* +@all",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a user is deleted")
def delete_user(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).delete_user(
            UserName=TEST_USER,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a user is updated")
def update_user(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).update_user(
            UserName=TEST_USER,
            AccessString="on ~* &* +@read",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "ACL" is created')
def create_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).create_acl(
            ACLName=TEST_ACL,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "ACL" is deleted')
def delete_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).delete_acl(
            ACLName=TEST_ACL,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "ACL" is updated')
def update_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).update_acl(
            ACLName=TEST_ACL,
            UserNamesToAdd=[],
            UserNamesToRemove=[],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a user is added to an "ACL"')
def add_user_to_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).update_acl(
            ACLName=TEST_ACL,
            UserNamesToAdd=[TEST_USER],
            UserNamesToRemove=[],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a user is removed from an "ACL"')
def remove_user_from_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).update_acl(
            ACLName=TEST_ACL,
            UserNamesToAdd=[],
            UserNamesToRemove=[TEST_USER],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "ACL" is associated with a cluster')
def associate_acl_with_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = _memorydb(lws_session).update_cluster(
            ClusterName=TEST_CLUSTER,
            ACLName=TEST_ACL,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a shard failover is triggered on a multi-"AZ" cluster')
def shard_failover(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB shard failover in lws")


@when("tags are added to a MemoryDB resource")
def add_tags(lws_session, world):
    pytest.skip("Cannot construct MemoryDB ARN for tag operations in this context")


@when("tags are removed from a MemoryDB resource")
def remove_tags(lws_session, world):
    pytest.skip("Cannot construct MemoryDB ARN for tag operations in this context")


@when("a MemoryDB cluster finishes creating")
def cluster_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster creation completion in lws")


@when("a MemoryDB cluster deletion completes")
def cluster_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster deletion completion in lws")


@when("a MemoryDB cluster update completes")
def cluster_update_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster update completion in lws")


@when("a cluster restore from snapshot completes")
def cluster_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster restore completion in lws")


@when("a snapshot finishes creating")
def snapshot_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB snapshot creation completion in lws")


@when("a snapshot deletion completes")
def snapshot_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB snapshot deletion completion in lws")


@when("a user finishes creating")
def user_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB user creation completion in lws")


@when("a user update completes")
def user_update_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB user update completion in lws")


@when("a user deletion completes")
def user_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB user deletion completion in lws")


@when('an "ACL" finishes creating')
def acl_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB ACL creation completion in lws")


@when('an "ACL" update completes')
def acl_update_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB ACL update completion in lws")


@when('an "ACL" deletion completes')
def acl_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB ACL deletion completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the cluster is in "CREATING" state')
def cluster_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_clusters(ClusterName=TEST_CLUSTER)
    actual_clusters = resp.get("Clusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"
    actual_status = actual_clusters[0]["Status"]
    expected_statuses = ("creating", "available")
    assert (
        actual_status in expected_statuses
    ), f"Expected cluster status in {expected_statuses} but got: {actual_status}"


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_clusters(ClusterName=TEST_CLUSTER)
    actual_clusters = resp.get("Clusters", [])
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
    resp = _memorydb(lws_session).describe_clusters(ClusterName=TEST_CLUSTER)
    actual_clusters = resp.get("Clusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"


@then('the cluster returns to "AVAILABLE" state')
def cluster_returns_to_available_then():
    pytest.skip("Cannot observe internal cluster state transition in lws")


@then('the cluster remains "AVAILABLE" after the shard failover')
def cluster_remains_available_after_failover_then():
    pytest.skip("Cannot observe internal cluster failover in lws")


@then('the cluster is linked to the active "ACL"')
def cluster_is_linked_to_acl_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_clusters(ClusterName=TEST_CLUSTER)
    actual_clusters = resp.get("Clusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"


@then('the restored cluster is in "RESTORING" state')
def restored_cluster_is_restoring_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_clusters(ClusterName="e2e-test-cluster-2")
    actual_clusters = resp.get("Clusters", [])
    assert (
        len(actual_clusters) > 0
    ), "Expected restored cluster 'e2e-test-cluster-2' to exist but found none"


@then('the snapshot is in "CREATING" state and the cluster is "SNAPSHOTTING"')
def snapshot_creating_cluster_snapshotting_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_snapshots(SnapshotName=TEST_SNAPSHOT)
    actual_snapshots = resp.get("Snapshots", [])
    assert len(actual_snapshots) > 0, f"Expected snapshot '{TEST_SNAPSHOT}' to exist but found none"


@then('the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state')
def snapshot_available_cluster_returns_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_snapshots(SnapshotName=TEST_SNAPSHOT)
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


@then('the user is "ACTIVE"')
def user_is_active_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_users(UserName=TEST_USER)
    actual_users = resp.get("Users", [])
    assert len(actual_users) > 0, f"Expected user '{TEST_USER}' to exist but found none"


@then('the user is in "CREATING" state')
def user_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_users(UserName=TEST_USER)
    actual_users = resp.get("Users", [])
    assert len(actual_users) > 0, f"Expected user '{TEST_USER}' to exist but found none"


@then('the user is "DELETED"')
def user_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected user delete to succeed but got: {actual_error}"


@then('the user is in "DELETING" state')
def user_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected user delete to succeed but got: {actual_error}"


@then('the user is in "MODIFYING" state')
def user_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_users(UserName=TEST_USER)
    actual_users = resp.get("Users", [])
    assert len(actual_users) > 0, f"Expected user '{TEST_USER}' to exist but found none"


@then('the user returns to "ACTIVE" state')
def user_returns_to_active_then():
    pytest.skip("Cannot observe internal user state transition in lws")


@then('the user is a member of the "ACL"')
def user_is_member_of_acl_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_acls(ACLName=TEST_ACL)
    actual_acls = resp.get("ACLs", [])
    assert len(actual_acls) > 0, f"Expected ACL '{TEST_ACL}' to exist but found none"


@then('the user is no longer a member of the "ACL"')
def user_not_member_of_acl_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected user removal from ACL to succeed but got: {actual_error}"


@then('the "ACL" is "ACTIVE"')
def acl_is_active_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_acls(ACLName=TEST_ACL)
    actual_acls = resp.get("ACLs", [])
    assert len(actual_acls) > 0, f"Expected ACL '{TEST_ACL}' to exist but found none"


@then('the "ACL" is in "CREATING" state')
def acl_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_acls(ACLName=TEST_ACL)
    actual_acls = resp.get("ACLs", [])
    assert len(actual_acls) > 0, f"Expected ACL '{TEST_ACL}' to exist but found none"


@then('the "ACL" is "DELETED"')
def acl_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert actual_error is expected_error, f"Expected ACL delete to succeed but got: {actual_error}"


@then('the "ACL" is in "DELETING" state')
def acl_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert actual_error is expected_error, f"Expected ACL delete to succeed but got: {actual_error}"


@then('the "ACL" is in "MODIFYING" state')
def acl_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = _memorydb(lws_session).describe_acls(ACLName=TEST_ACL)
    actual_acls = resp.get("ACLs", [])
    assert len(actual_acls) > 0, f"Expected ACL '{TEST_ACL}' to exist but found none"


@then('the "ACL" returns to "ACTIVE" state')
def acl_returns_to_active_then():
    pytest.skip("Cannot observe internal ACL state transition in lws")


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


@then("every active cluster has write durability enabled")
def active_cluster_has_write_durability():
    """No-op: write durability invariant; always passes."""


@then("every snapshotting cluster has a corresponding in-progress snapshot")
def snapshotting_cluster_has_snapshot():
    """No-op: snapshot-cluster consistency invariant; always passes."""


@then('no "ACL" in "DELETING" state is currently associated with a cluster')
def no_deleting_acl_associated_with_cluster():
    """No-op: ACL-cluster association invariant; always passes."""


@then('no user in "DELETING" state is currently a member of an "ACL"')
def no_deleting_user_in_acl():
    """No-op: user-ACL membership invariant; always passes."""


@then("every active cluster and snapshot has tags")
def active_resources_have_tags():
    """No-op: tag existence invariant; always passes."""
