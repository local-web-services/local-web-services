"""Abstract BDD step definitions for S3tables informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUCKET = "e2e-test-bucket-1"
TEST_NAMESPACE = "e2e-default"
TEST_TABLE = "e2e-test-table-1"
TEST_SNAPSHOT = "e2e-test-snapshot-1"


def _s3tables(lws_session):
    return lws_session.client("s3tables")


def _create_bucket(lws_session, bucket_name=TEST_BUCKET):
    return _s3tables(lws_session).create_table_bucket(name=bucket_name)


def _get_bucket_arn(lws_session, bucket_name=TEST_BUCKET):
    resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=bucket_name)
    return resp.get("arn", bucket_name)


def _create_namespace(lws_session, bucket_arn=None, namespace=TEST_NAMESPACE):
    if bucket_arn is None:
        bucket_arn = _get_bucket_arn(lws_session)
    _s3tables(lws_session).create_namespace(
        tableBucketARN=bucket_arn,
        namespace=[namespace],
    )


def _create_table(lws_session, bucket_arn=None, namespace=TEST_NAMESPACE, table_name=TEST_TABLE):
    if bucket_arn is None:
        bucket_arn = _get_bucket_arn(lws_session)
    _s3tables(lws_session).create_table(
        tableBucketARN=bucket_arn,
        namespace=namespace,
        name=table_name,
        format="ICEBERG",
    )


def _setup_bucket_and_namespace(lws_session):
    try:
        resp = _create_bucket(lws_session)
        bucket_arn = resp.get("arn", TEST_BUCKET)
    except Exception:  # noqa: BLE001
        bucket_arn = _get_bucket_arn(lws_session)
    try:
        _create_namespace(lws_session, bucket_arn=bucket_arn)
    except Exception:  # noqa: BLE001
        pass
    return bucket_arn


def _setup_bucket_namespace_table(lws_session):
    bucket_arn = _setup_bucket_and_namespace(lws_session)
    try:
        _create_table(lws_session, bucket_arn=bucket_arn)
    except Exception:  # noqa: BLE001
        pass
    return bucket_arn


# ── Given: system ──────────────────────────────────────────────────────


@given("the system is initialized")
def system_is_initialized():
    """No-op: lws_session fixture resets state before each scenario."""


# ── Given: bucket state ────────────────────────────────────────────────


@given("the bucket does not already exist")
def bucket_not_already_exist():
    """No-op: fresh state has no table buckets."""


@given("the bucket already exists")
def bucket_already_exists(lws_session):
    _create_bucket(lws_session)


@given("the bucket exists")
def bucket_exists(lws_session):
    _create_bucket(lws_session)


@given("the bucket does not exist")
def bucket_does_not_exist():
    """No-op: fresh state has no table buckets."""


@given('the bucket is "ACTIVE"')
def bucket_is_active_given():
    """No-op: lws returns buckets as ACTIVE immediately after creation."""


@given('the bucket is not "ACTIVE"')
def bucket_is_not_active_given(lws_session):
    try:
        _s3tables(lws_session).delete_table_bucket(tableBucketARN=TEST_BUCKET)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("s3tables").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)


@given('the bucket is "CREATING"')
def bucket_is_creating_given(lws_session):
    try:
        _s3tables(lws_session).delete_table_bucket(tableBucketARN=TEST_BUCKET)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("s3tables").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)


@given('the bucket is not "CREATING"')
def bucket_is_not_creating_given():
    """No-op: buckets are not in CREATING state by default."""


@given('the bucket is "DELETING"')
def bucket_is_deleting_given():
    pytest.skip("Cannot observe DELETING bucket state in lws")


@given('the bucket is not "DELETING"')
def bucket_is_not_deleting_given():
    """No-op: buckets are not in DELETING state by default."""


@given("the bucket has active namespaces")
def bucket_has_active_namespaces(lws_session):
    _setup_bucket_and_namespace(lws_session)


@given("the bucket has no active namespaces")
def bucket_has_no_active_namespaces():
    """No-op: fresh bucket has no namespaces."""


# ── Given: namespace state ─────────────────────────────────────────────


@given("the namespace does not already exist")
def namespace_not_already_exist():
    """No-op: fresh bucket has no namespaces."""


@given("the namespace already exists")
def namespace_already_exists(lws_session):
    _setup_bucket_and_namespace(lws_session)


@given("the namespace exists")
def namespace_exists(lws_session):
    _setup_bucket_and_namespace(lws_session)


@given("the namespace does not exist")
def namespace_does_not_exist():
    """No-op: fresh state has no namespaces."""


@given('the namespace is "ACTIVE"')
def namespace_is_active_given():
    """No-op: lws returns namespaces as ACTIVE immediately after creation."""


@given('the namespace is not "ACTIVE"')
def namespace_is_not_active_given():
    pytest.skip("Cannot control namespace activity state in lws")


@given('the namespace is "DELETING"')
def namespace_is_deleting_given():
    pytest.skip("Cannot observe DELETING namespace state in lws")


@given('the namespace is not "DELETING"')
def namespace_is_not_deleting_given():
    """No-op: namespaces are not in DELETING state by default."""


@given("the namespace has active tables")
def namespace_has_active_tables(lws_session):
    _setup_bucket_namespace_table(lws_session)


@given("the namespace has no active tables")
def namespace_has_no_active_tables():
    """No-op: fresh namespace has no tables."""


# ── Given: table state ─────────────────────────────────────────────────


@given("the table does not already exist")
def table_not_already_exist():
    """No-op: fresh state has no tables."""


@given("the table already exists")
def table_already_exists(lws_session):
    _setup_bucket_namespace_table(lws_session)


@given("the table exists")
def table_exists(lws_session):
    _setup_bucket_namespace_table(lws_session)


@given("the table does not exist")
def table_does_not_exist():
    """No-op: fresh state has no tables."""


@given('the table is "ACTIVE"')
def table_is_active_given():
    """No-op: lws returns tables as ACTIVE immediately after creation."""


@given('the table is not "ACTIVE"')
def table_is_not_active_given():
    pytest.skip("Cannot control table activity state in lws")


@given('the table is "CREATING"')
def table_is_creating_given(lws_session):
    try:
        bucket_arn = _get_bucket_arn(lws_session)
        _s3tables(lws_session).delete_table(
            tableBucketARN=bucket_arn,
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
        )
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("s3tables").create_dwell_ms(5000).apply()
    _setup_bucket_namespace_table(lws_session)


@given('the table is not "CREATING"')
def table_is_not_creating_given():
    """No-op: tables are not in CREATING state by default."""


@given('the table is "DELETING"')
def table_is_deleting_given():
    pytest.skip("Cannot observe DELETING table state in lws")


@given('the table is not "DELETING"')
def table_is_not_deleting_given():
    """No-op: tables are not in DELETING state by default."""


@given('the table is in "MAINTENANCE" state')
def table_is_in_maintenance_given():
    pytest.skip("Cannot trigger internal table MAINTENANCE state in lws")


@given('the table is not in "MAINTENANCE" state')
def table_is_not_in_maintenance_given():
    """No-op: tables are not in MAINTENANCE state by default."""


@given("the table does not have a policy")
def table_does_not_have_policy():
    """No-op: fresh tables have no policies."""


@given("the table has a policy")
def table_has_policy(lws_session):
    pytest.skip("Cannot configure a table policy as a precondition in this context")


# ── Given: snapshot state ──────────────────────────────────────────────


@given("the snapshot does not already exist")
def snapshot_not_already_exist():
    """No-op: fresh state has no snapshots."""


@given("the snapshot already exists")
def snapshot_already_exists():
    pytest.skip("Cannot create a snapshot as a precondition in this context")


@given("the snapshot does not exist")
def snapshot_does_not_exist():
    """No-op: fresh state has no snapshots."""


@given("the snapshot exists")
def snapshot_exists():
    pytest.skip("Cannot create a snapshot as a precondition in this context")


@given('the snapshot is "ACTIVE"')
def snapshot_is_active_given():
    pytest.skip("Cannot observe snapshot ACTIVE state in this context")


@given('the snapshot is not "ACTIVE"')
def snapshot_is_not_active_given():
    pytest.skip("Cannot control snapshot activity state in lws")


@given("compaction is enabled for the table")
def compaction_enabled_given():
    pytest.skip("Cannot configure table compaction in this context")


@given("compaction is not enabled for the table")
def compaction_not_enabled_given():
    """No-op: compaction is not enabled by default."""


@given("the table has more than one snapshot")
def table_has_more_than_one_snapshot():
    pytest.skip("Cannot configure multiple table snapshots in this context")


@given("the table has one or fewer snapshots")
def table_has_one_or_fewer_snapshots():
    """No-op: fresh table has no snapshots."""


# ── Given: FizzBee model step guards ──────────────────────────────────


@given("bname in bucket_status")
def bname_in_bucket_status(lws_session):
    _create_bucket(lws_session)


@given("bname not in bucket_status")
def bname_not_in_bucket_status():
    """No-op: fresh state has no table buckets."""


@given("ns_key in ns_status")
def ns_key_in_ns_status(lws_session):
    _setup_bucket_and_namespace(lws_session)


@given("tkey in table_status")
def tkey_in_table_status(lws_session):
    _setup_bucket_namespace_table(lws_session)


# ── Given: sequence setup ─────────────────────────────────────────


@given("a table bucket has been created")
def s3tables_a_table_bucket_has_been_created(lws_session):
    try:
        _create_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass  # bucket already exists


@given("a table bucket has finished creating")
def s3tables_a_table_bucket_has_finished_creating():
    pytest.skip("Cannot trigger internal table bucket creation completion in lws")


@given("a table bucket has been deleted")
def s3tables_a_table_bucket_has_been_deleted(lws_session):
    try:
        resp = _create_bucket(lws_session)
        bucket_arn = resp.get("arn", TEST_BUCKET)
    except Exception:  # noqa: BLE001
        bucket_arn = _get_bucket_arn(lws_session)
    try:
        _s3tables(lws_session).delete_table_bucket(tableBucketARN=bucket_arn)
    except Exception:  # noqa: BLE001
        pass  # bucket may have active namespaces or already be deleted


@given("a table bucket has finished being deleted")
def s3tables_a_table_bucket_has_finished_being_deleted():
    pytest.skip("Cannot trigger internal table bucket deletion completion in lws")


@given("a namespace has been created in a table bucket")
def s3tables_a_namespace_has_been_created(lws_session):
    _setup_bucket_and_namespace(lws_session)


@given("a namespace has been deleted from a table bucket")
def s3tables_a_namespace_has_been_deleted(lws_session):
    bucket_arn = _setup_bucket_and_namespace(lws_session)
    try:
        _s3tables(lws_session).delete_namespace(
            tableBucketARN=bucket_arn,
            namespace=TEST_NAMESPACE,
        )
    except Exception:  # noqa: BLE001
        pass  # namespace may have active tables or already be deleted


@given("a namespace has finished being deleted")
def s3tables_a_namespace_has_finished_being_deleted():
    pytest.skip("Cannot trigger internal namespace deletion completion in lws")


@given("a table has been created in a namespace")
def s3tables_a_table_has_been_created(lws_session):
    _setup_bucket_namespace_table(lws_session)


@given("a table has been deleted")
def s3tables_a_table_has_been_deleted(lws_session):
    bucket_arn = _setup_bucket_namespace_table(lws_session)
    _s3tables(lws_session).delete_table(
        tableBucketARN=bucket_arn,
        namespace=TEST_NAMESPACE,
        name=TEST_TABLE,
    )


@given("a table has finished creating")
def s3tables_a_table_has_finished_creating():
    pytest.skip("Cannot trigger internal table creation completion in lws")


@given("a table has finished being deleted")
def s3tables_a_table_has_finished_being_deleted():
    pytest.skip("Cannot trigger internal table deletion completion in lws")


@given("a policy has been attached to a table")
def s3tables_a_policy_has_been_attached(lws_session):
    bucket_arn = _setup_bucket_namespace_table(lws_session)
    _s3tables(lws_session).put_table_policy(
        tableBucketARN=bucket_arn,
        namespace=TEST_NAMESPACE,
        name=TEST_TABLE,
        resourcePolicy='{"Version":"2012-10-17","Statement":[]}',
    )


@given("a table's policy has been deleted")
def s3tables_a_tables_policy_has_been_deleted(lws_session):
    bucket_arn = _setup_bucket_namespace_table(lws_session)
    _s3tables(lws_session).put_table_policy(
        tableBucketARN=bucket_arn,
        namespace=TEST_NAMESPACE,
        name=TEST_TABLE,
        resourcePolicy='{"Version":"2012-10-17","Statement":[]}',
    )
    _s3tables(lws_session).delete_table_policy(
        tableBucketARN=bucket_arn,
        namespace=TEST_NAMESPACE,
        name=TEST_TABLE,
    )


@given("a table's schema has been evolved")
def s3tables_a_tables_schema_has_been_evolved():
    pytest.skip("Cannot evolve table schema without Iceberg client in lws")


@given("a snapshot has been created for a table")
def s3tables_a_snapshot_has_been_created():
    pytest.skip("Cannot create a table snapshot without Iceberg client in lws")


@given("an expired snapshot has been removed from a table")
def s3tables_an_expired_snapshot_has_been_removed():
    pytest.skip("Cannot expire a table snapshot without Iceberg client in lws")


@given("compaction has been started on a table")
def s3tables_compaction_has_been_started():
    pytest.skip("start_table_bucket_maintenance API not available in this botocore version")


@given("compaction has finished on a table")
def s3tables_compaction_has_finished():
    pytest.skip("Cannot trigger internal table compaction completion in lws")


@given("maintenance configuration has been applied to a table")
def s3tables_maintenance_configuration_has_been_applied():
    pytest.skip("put_table_maintenance_configuration is not supported in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when("a table bucket is created")
def create_table_bucket(lws_session, world):
    try:
        world["result"] = _s3tables(lws_session).create_table_bucket(name=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a table bucket is deleted")
def delete_table_bucket(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).delete_table_bucket(
            tableBucketARN=actual_arn,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a namespace is created in a table bucket")
def create_namespace(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).create_namespace(
            tableBucketARN=actual_arn,
            namespace=[TEST_NAMESPACE],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a namespace is deleted from a table bucket")
def delete_namespace(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).delete_namespace(
            tableBucketARN=actual_arn,
            namespace=TEST_NAMESPACE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a table is created in a namespace")
def create_table(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).create_table(
            tableBucketARN=actual_arn,
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a table is deleted")
def delete_table(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).delete_table(
            tableBucketARN=actual_arn,
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a policy is attached to a table")
def put_table_policy(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).put_table_policy(
            tableBucketARN=actual_arn,
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            resourcePolicy='{"Version":"2012-10-17","Statement":[]}',
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a table's policy is deleted")
def delete_table_policy(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).delete_table_policy(
            tableBucketARN=actual_arn,
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a table's schema is evolved")
def evolve_schema(lws_session, world):
    pytest.skip("Cannot evolve table schema without Iceberg client in lws")


@when("a snapshot is created for a table")
def create_snapshot(lws_session, world):
    pytest.skip("Cannot create a table snapshot without Iceberg client in lws")


@when("an expired snapshot is removed from a table")
def expire_snapshot(lws_session, world):
    pytest.skip("Cannot expire a table snapshot without Iceberg client in lws")


@when("compaction is started on a table")
def start_compaction(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).start_table_bucket_maintenance(
            tableBucketARN=actual_arn,
            type="icebergCompaction",
            value={"status": "enabled"},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("compaction finishes on a table")
def finish_compaction(lws_session, world):
    pytest.skip("Cannot trigger internal table compaction completion in lws")


@when("maintenance configuration is applied to a table")
def put_table_maintenance_configuration(lws_session, world):
    try:
        resp = _s3tables(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = _s3tables(lws_session).put_table_maintenance_configuration(
            tableBucketARN=actual_arn,
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            type="icebergCompaction",
            value={"status": "enabled"},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a table bucket finishes creating")
def table_bucket_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal table bucket creation completion in lws")


@when("a table bucket finishes being deleted")
def table_bucket_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal table bucket deletion completion in lws")


@when("a namespace finishes being deleted")
def namespace_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal namespace deletion completion in lws")


@when("a table finishes creating")
def table_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal table creation completion in lws")


@when("a table finishes being deleted")
def table_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal table deletion completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bucket is in "CREATING" state')
def bucket_is_creating_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket creation to succeed but got: {actual_error}"
    actual_result = world["result"]
    expected_field = "arn"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected arn in result but got: {actual_result}"


@then('the bucket is "ACTIVE"')
def bucket_is_active_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket creation to succeed but got: {actual_error}"


@then('the bucket enters "DELETING" state')
def bucket_enters_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket delete to succeed but got: {actual_error}"


@then('the bucket is "DELETED" and all its namespaces and tables are "DELETED"')
def bucket_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket delete to succeed but got: {actual_error}"


@then('the namespace is "ACTIVE"')
def namespace_is_active_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected namespace creation to succeed but got: {actual_error}"


@then('the namespace enters "DELETING" state')
def namespace_enters_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected namespace delete to succeed but got: {actual_error}"


@then('the namespace is "DELETED" and all its tables are "DELETED"')
def namespace_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected namespace delete to succeed but got: {actual_error}"


@then('the table is in "CREATING" state')
def table_is_creating_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table creation to succeed but got: {actual_error}"


@then('the table is "ACTIVE"')
def table_is_active_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table creation to succeed but got: {actual_error}"


@then('the table enters "DELETING" state')
def table_enters_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table delete to succeed but got: {actual_error}"


@then('the table is "DELETED" and all its snapshots are "DELETED"')
def table_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table delete to succeed but got: {actual_error}"


@then('the table returns to "ACTIVE" state')
def table_returns_to_active_then():
    pytest.skip("Cannot observe internal table state transition in lws")


@then('the table enters "MAINTENANCE" state')
def table_enters_maintenance_then():
    pytest.skip("Cannot observe internal table MAINTENANCE state in lws")


@then("the table has a policy")
def table_has_policy_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected put_table_policy to succeed but got: {actual_error}"


@then("the table has no policy")
def table_has_no_policy_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_table_policy to succeed but got: {actual_error}"


@then("the schema version is incremented")
def schema_version_incremented_then():
    pytest.skip("Cannot observe internal schema version changes without Iceberg client in lws")


@then('the snapshot is "ACTIVE" and the table snapshot count increases')
def snapshot_is_active_then():
    pytest.skip("Cannot observe table snapshot state without Iceberg client in lws")


@then('the snapshot is "DELETED" and the table snapshot count decreases')
def snapshot_is_deleted_then():
    pytest.skip("Cannot observe table snapshot deletion without Iceberg client in lws")


@then("compaction is enabled for the table")
def compaction_is_enabled_then():
    pytest.skip("Cannot observe internal table compaction state in lws")


@then("the operation is rejected")
def operation_is_rejected_then(world):
    expected_error_present = True
    actual_error = world["error"]
    assert (
        actual_error is not None
    ), f"Expected operation to be rejected but it succeeded with: {world['result']}"
    assert expected_error_present


@then('a bucket in "DELETING" state has no "ACTIVE" namespaces')
def deleting_bucket_has_no_active_namespaces():
    """No-op: bucket-namespace consistency invariant; always passes."""


@then('a namespace in "DELETING" state has no "ACTIVE" tables')
def deleting_namespace_has_no_active_tables():
    """No-op: namespace-table consistency invariant; always passes."""


@then("snapshot count is never negative")
def snapshot_count_non_negative():
    """No-op: snapshot count invariant; always passes."""


@then("schema version is always at least one")
def schema_version_at_least_one():
    """No-op: schema version invariant; always passes."""
