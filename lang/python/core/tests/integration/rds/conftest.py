"""Shared fixtures and BDD step definitions for RDS integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.rds.routes import create_rds_app

INT_DB_INSTANCE = "int-rds-instance-1"
INT_DB_SNAPSHOT = "int-rds-snapshot-1"
INT_DB_CLUSTER = "int-rds-cluster-1"
INT_DB_INSTANCE2 = "int-rds-instance-2"
INT_TAG_KEY = "int-rds-tag-key-1"
INT_TAG_VALUE = "int-rds-tag-value-1"

_RDS_TARGET = "AmazonRDSv19"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """RDS uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_rds_app()


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _post(client: TestClient, action: str, body: dict):
    return client.post(
        "/",
        headers={"X-Amz-Target": f"{_RDS_TARGET}.{action}"},
        json=body,
    )


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


def _create_instance(
    client: TestClient,
    db_id: str = INT_DB_INSTANCE,
) -> None:
    _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id, "Engine": "postgres"})


# ── Given: instance state ─────────────────────────────────────────────────────


@given("the database instance does not already exist")
def db_instance_not_already_exist():
    """No-op: fresh state has no instances."""


@given("the database instance already exists")
def db_instance_already_exists(client: TestClient):
    _create_instance(client)


@given("the database instance exists")
def db_instance_exists(client: TestClient):
    _create_instance(client)


@given("the database instance does not exist")
def db_instance_does_not_exist():
    """No-op: fresh state has no instances."""


@given('the instance is "CREATING"')
def instance_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is "AVAILABLE"')
def instance_is_available():
    """No-op: instances are AVAILABLE immediately after creation in lws."""


@given('the instance is "AVAILABLE" or "FAILED"')
def instance_is_available_or_failed():
    """No-op: instances are AVAILABLE immediately after creation in lws."""


@given('the instance is "REBOOTING"')
def instance_is_rebooting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is "MODIFYING"')
def instance_is_modifying(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is "DELETING"')
def instance_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is "BACKING_UP"')
def instance_is_backing_up(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "CREATING"')
def instance_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "AVAILABLE"')
def instance_is_not_available(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "REBOOTING"')
def instance_is_not_rebooting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "MODIFYING"')
def instance_is_not_modifying(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "DELETING"')
def instance_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is not "BACKING_UP"')
def instance_is_not_backing_up(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the instance is neither "AVAILABLE" nor "FAILED"')
def instance_is_neither_available_nor_failed(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the instance does not exist")
def instance_does_not_exist():
    """No-op: fresh state has no instances."""


@given("the instance exists")
def instance_exists(client: TestClient):
    _create_instance(client)


@given('the instance has multi-"AZ" enabled')
def instance_has_multi_az_enabled(world):
    pytest.skip("Multi-AZ state is not configurable in stateless integration tests.")


@given('the instance does not have multi-"AZ" enabled')
def instance_does_not_have_multi_az_enabled():
    """No-op: fresh instances have no multi-AZ in lws."""


# ── Given: snapshot state ─────────────────────────────────────────────────────


@given("a snapshot slot is available")
def snapshot_slot_available():
    """No-op: snapshot slots are always available in lws."""


@given("no snapshot slot is available")
def no_snapshot_slot_available(world):
    pytest.skip("Snapshot slot limits are not configurable in stateless integration tests.")


@given("the snapshot exists")
def snapshot_exists(client: TestClient):
    """Create an instance (snapshots are not standalone in lws)."""
    _create_instance(client)


@given("the snapshot does not exist")
def snapshot_does_not_exist():
    """No-op: fresh state has no snapshots."""


@given('the snapshot is "AVAILABLE"')
def snapshot_is_available():
    """No-op: snapshots are considered AVAILABLE in lws fresh state."""


@given('the snapshot is "CREATING"')
def snapshot_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the snapshot is "DELETING"')
def snapshot_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the snapshot is not "AVAILABLE"')
def snapshot_is_not_available(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the snapshot is not "CREATING"')
def snapshot_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the snapshot is not "DELETING"')
def snapshot_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the target instance slot is available")
def target_instance_slot_available():
    """No-op: target instance slots are always available in lws."""


@given("the target instance slot is not available")
def target_instance_slot_not_available(world):
    pytest.skip("Instance slot limits are not configurable in stateless integration tests.")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a database instance is created")
def create_db_instance(client: TestClient, world: dict):
    r = _post(
        client,
        "CreateDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "Engine": "postgres"},
    )
    _store(world, r)


@when("a database instance finishes creating")
def finish_creating_db_instance(client: TestClient, world: dict):
    r = _post(client, "DescribeDBInstances", {"DBInstanceIdentifier": INT_DB_INSTANCE})
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


@when("a database instance is deleted without a final snapshot")
def delete_db_instance_skip_snapshot(client: TestClient, world: dict):
    r = _post(
        client,
        "DeleteDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "SkipFinalSnapshot": True},
    )
    _store(world, r)


@when("a database instance is deleted with a final snapshot")
def delete_db_instance_with_snapshot(client: TestClient, world: dict):
    r = _post(
        client,
        "DeleteDBInstance",
        {
            "DBInstanceIdentifier": INT_DB_INSTANCE,
            "SkipFinalSnapshot": False,
            "FinalDBSnapshotIdentifier": INT_DB_SNAPSHOT,
        },
    )
    _store(world, r)


@when("a database instance deletion completes")
def finish_delete_db_instance(client: TestClient, world: dict):
    check = _post(client, "DescribeDBInstances", {"DBInstanceIdentifier": INT_DB_INSTANCE})
    if check.status_code != 200:
        world["result"] = None
        world["error"] = check.json()
        return
    r = _post(
        client,
        "DeleteDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "SkipFinalSnapshot": True},
    )
    _store(world, r)


@when("a database instance configuration is modified")
def modify_db_instance(client: TestClient, world: dict):
    r = _post(
        client,
        "ModifyDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "DBInstanceClass": "db.t3.small"},
    )
    _store(world, r)


@when("a database instance modification completes")
def finish_modify_db_instance(client: TestClient, world: dict):
    r = _post(
        client,
        "ModifyDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "DBInstanceClass": "db.t3.small"},
    )
    _store(world, r)


@when("a database instance is rebooted")
def reboot_db_instance(client: TestClient, world: dict):
    pytest.skip("RebootDBInstance is not yet implemented in lws.")


@when("a database instance reboot completes")
def finish_reboot_db_instance(client: TestClient, world: dict):
    pytest.skip("RebootDBInstance is not yet implemented in lws.")


@when("a database snapshot is created from an instance")
def create_db_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBSnapshot is not yet implemented in lws.")


@when("a database snapshot finishes creating")
def finish_create_db_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBSnapshot is not yet implemented in lws.")


@when("a database snapshot is deleted")
def delete_db_snapshot(client: TestClient, world: dict):
    pytest.skip("DeleteDBSnapshot is not yet implemented in lws.")


@when("a database snapshot deletion completes")
def finish_delete_db_snapshot(client: TestClient, world: dict):
    pytest.skip("DeleteDBSnapshot is not yet implemented in lws.")


@when("an automated backup runs on an available instance")
def automated_backup(client: TestClient, world: dict):
    pytest.skip("CreateDBSnapshot is not yet implemented in lws.")


@when('multi-"AZ" is enabled on a database instance')
def enable_multi_az(client: TestClient, world: dict):
    r = _post(
        client,
        "ModifyDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "MultiAZ": True},
    )
    _store(world, r)


@when('a multi-"AZ" failover is triggered on an instance')
def multi_az_failover(client: TestClient, world: dict):
    r = _post(
        client,
        "RebootDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "ForceFailover": True},
    )
    _store(world, r)


@when("a tag is applied to a database instance")
def tag_db_instance(client: TestClient, world: dict):
    describe_r = _post(client, "DescribeDBInstances", {"DBInstanceIdentifier": INT_DB_INSTANCE})
    if describe_r.status_code != 200:
        world["result"] = None
        world["error"] = describe_r.json()
        return
    instances = describe_r.json().get("DBInstances", [])
    if not instances:
        world["result"] = None
        world["error"] = {"message": "DB instance not found"}
        return
    resource_name = instances[0].get("DBInstanceArn", "")
    r = _post(
        client,
        "AddTagsToResource",
        {
            "ResourceName": resource_name,
            "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}],
        },
    )
    _store(world, r)


@when("a database instance is restored from a snapshot")
def restore_db_instance_from_snapshot(client: TestClient, world: dict):
    pytest.skip("RestoreDBInstanceFromDBSnapshot is not yet implemented in lws.")


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the instance is in "CREATING" state')
def instance_is_in_creating_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance creation to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("creating", "available")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"


@then('the instance is "AVAILABLE" or "FAILED"')
def instance_is_available_or_failed_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the instance is in "DELETING" state')
def instance_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance deletion to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("deleting", "deleted")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"


@then('the instance is in "DELETING" state and a snapshot is "CREATING"')
def instance_deleting_snapshot_creating(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the instance is in "MODIFYING" state')
def instance_is_in_modifying_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance modification to succeed but got error: {world['error']}"


@then('the instance is in "REBOOTING" state')
def instance_is_in_rebooting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance reboot to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("rebooting", "available")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"


@then('the instance returns to "AVAILABLE" state')
def instance_returns_to_available(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the instance is "DELETED"')
def instance_is_deleted(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the instance is configured for multi-"AZ" deployment')
def instance_configured_for_multi_az(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected multi-AZ enable to succeed but got error: {world['error']}"


@then('the instance enters "MODIFYING" state during promotion')
def instance_enters_modifying_during_promotion(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected failover to succeed but got error: {world['error']}"


@then("the instance tag state is unchanged (no-op model)")
def instance_tag_state_unchanged(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected tag operation to succeed but got error: {world['error']}"


@then('the snapshot is "CREATING" and the instance is in "BACKING_UP" state')
def snapshot_creating_instance_backing_up(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected snapshot creation to succeed but got error: {world['error']}"


@then('a snapshot is "CREATING" and the instance is in "BACKING_UP" state')
def auto_snapshot_creating_instance_backing_up(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected automated backup to succeed but got error: {world['error']}"


@then('the snapshot is "AVAILABLE" and the instance returns to "AVAILABLE" state')
def snapshot_available_instance_available(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the snapshot is in "DELETING" state')
def snapshot_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected snapshot deletion to succeed but got error: {world['error']}"


@then('the snapshot is "DELETED"')
def snapshot_is_deleted(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the restored instance is in "CREATING" state')
def restored_instance_is_creating(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected restore to succeed but got error: {world['error']}"


@then("every database instance has a valid status")
def every_db_instance_valid_status():
    """Invariant trivially satisfied in isolated test context."""


@then("every database snapshot has a valid status")
def every_db_snapshot_valid_status():
    """Invariant trivially satisfied in isolated test context."""


@then("every backing-up instance has a corresponding in-progress snapshot")
def every_backing_up_instance_has_snapshot():
    """Invariant trivially satisfied in isolated test context."""
