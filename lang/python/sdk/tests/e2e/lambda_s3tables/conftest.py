"""Abstract BDD step definitions for LambdaS3tables integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_BUCKET = "e2e-test-table-bucket-1"
TEST_NAMESPACE = "e2e-test-namespace-1"
TEST_TABLE = "e2e-test-table-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _s3tables(lws_session):
    return lws_session.client("s3tables")


def _table_bucket_arn(name=TEST_BUCKET):
    return f"arn:aws:s3tables:us-east-1:000000000000:bucket/{name}"


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_table_bucket(lws_session, name=TEST_BUCKET):
    _s3tables(lws_session).create_table_bucket(name=name)


def _create_namespace(lws_session, bucket_name=TEST_BUCKET, namespace=TEST_NAMESPACE):
    try:
        _s3tables(lws_session).create_namespace(
            tableBucketARN=_table_bucket_arn(bucket_name),
            namespace=[namespace],
        )
    except Exception:  # noqa: BLE001
        pass


def _table_bucket_exists(lws_session, name=TEST_BUCKET):
    resp = _s3tables(lws_session).list_table_buckets()
    return any(b["name"] == name for b in resp.get("tableBuckets", []))


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def lambda_s3tables_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def lambda_s3tables_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def lambda_s3tables_function_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def lambda_s3tables_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def lambda_s3tables_function_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def lambda_s3tables_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


# ── Given: bucket state ───────────────────────────────────────────────


@given("the bucket does not already exist")
def lambda_s3tables_bucket_not_already_exist():
    """No-op: fresh state has no S3 table buckets."""


@given("the bucket already exists")
def lambda_s3tables_bucket_already_exists(lws_session):
    try:
        _create_table_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass


@given('the table bucket is "ACTIVE"')
def lambda_s3tables_table_bucket_is_active_given(lws_session):
    try:
        _create_table_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass


@given('the table bucket is not "ACTIVE"')
def lambda_s3tables_table_bucket_is_not_active_given():
    pytest.skip("Cannot put an S3 table bucket into a non-ACTIVE state in lws")


# ── Given: table state ────────────────────────────────────────────────


@given("the table does not already exist")
def lambda_s3tables_table_not_already_exist():
    """No-op: fresh state has no S3 Tables tables."""


@given("the table already exists")
def lambda_s3tables_table_already_exists(lws_session):
    try:
        _create_table_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _create_namespace(lws_session)
    try:
        _s3tables(lws_session).create_table(
            tableBucketARN=_table_bucket_arn(),
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
    except Exception:  # noqa: BLE001
        pass


@given("the table exists")
def lambda_s3tables_table_exists(lws_session):
    try:
        _create_table_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _create_namespace(lws_session)
    try:
        _s3tables(lws_session).create_table(
            tableBucketARN=_table_bucket_arn(),
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
    except Exception:  # noqa: BLE001
        pass


@given('the table is "ACTIVE"')
def lambda_s3tables_table_is_active_given(lws_session):
    try:
        _create_table_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _create_namespace(lws_session)
    try:
        _s3tables(lws_session).create_table(
            tableBucketARN=_table_bucket_arn(),
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
    except Exception:  # noqa: BLE001
        pass


@given('the table is "DELETING"')
def lambda_s3tables_table_is_deleting_given():
    pytest.skip("Cannot put an S3 Tables table into DELETING state in lws")


@given('the table is already "DELETING"')
def lambda_s3tables_table_is_already_deleting_given():
    pytest.skip("Cannot put an S3 Tables table into DELETING state in lws")


@given('the table is not "DELETING"')
def lambda_s3tables_table_is_not_deleting_given(lws_session):
    try:
        _create_table_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _create_namespace(lws_session)
    try:
        _s3tables(lws_session).create_table(
            tableBucketARN=_table_bucket_arn(),
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
    except Exception:  # noqa: BLE001
        pass


@given("the table does not exist")
def lambda_s3tables_table_does_not_exist():
    """No-op: fresh state has no S3 Tables tables."""


@given('no table is "ACTIVE"')
def lambda_s3tables_no_table_is_active():
    """No-op: fresh state has no S3 Tables tables."""


# ── Given: invocation state ───────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def lambda_s3tables_invocation_is_in_progress():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given('no invocation is "IN_PROGRESS"')
def lambda_s3tables_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an invocation slot is available")
def lambda_s3tables_invocation_slot_available():
    """No-op: always room for invocations."""


@given("no invocation slot is available")
def lambda_s3tables_no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")


@given("a record slot is available")
def lambda_s3tables_record_slot_available():
    """No-op: always room for records."""


@given("no record slot is available")
def lambda_s3tables_no_record_slot_available():
    pytest.skip("Cannot exhaust record slot limit")


# ── When: actions ──────────────────────────────────────────────────────


@when("a Lambda function is deployed")
def lambda_s3tables_deploy_function(lws_session, world):
    try:
        resp = _lambda(lws_session).create_function(
            FunctionName=TEST_FUNC,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an S3 table bucket is created")
def lambda_s3tables_create_table_bucket(lws_session, world):
    try:
        resp = _s3tables(lws_session).create_table_bucket(name=TEST_BUCKET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a table is created in the table bucket")
def lambda_s3tables_create_table(lws_session, world):
    try:
        if not _table_bucket_exists(lws_session):
            _create_table_bucket(lws_session)
        _create_namespace(lws_session)
        resp = _s3tables(lws_session).create_table(
            tableBucketARN=_table_bucket_arn(),
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a table deletion is initiated")
def lambda_s3tables_initiate_table_deletion(world):
    pytest.skip("Cannot trigger S3 Tables table deletion in lws")


@when("the Lambda function is invoked")
def lambda_s3tables_invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function writes a record to an "ACTIVE" table and succeeds')
def lambda_s3tables_function_writes_record_succeeds(world):
    pytest.skip("Cannot trigger internal Lambda->S3Tables write in lws")


@when("the Lambda function fails to write because the table is being deleted")
def lambda_s3tables_function_fails_write_table_deleting(world):
    pytest.skip("Cannot trigger internal Lambda->S3Tables write failure in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def lambda_s3tables_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the bucket is "ACTIVE"')
def lambda_s3tables_bucket_is_active_then(lws_session):
    expected_exists = True
    actual_exists = _table_bucket_exists(lws_session)
    assert (
        actual_exists is expected_exists
    ), f"Expected S3 table bucket '{TEST_BUCKET}' to be ACTIVE but it was not found"


@then('the table is "ACTIVE"')
def lambda_s3tables_table_is_active_then(lws_session):
    resp = _s3tables(lws_session).list_tables(tableBucketARN=_table_bucket_arn())
    actual_tables = [t["name"] for t in resp.get("tables", [])]
    expected_table = TEST_TABLE
    assert (
        expected_table in actual_tables
    ), f"Expected table '{expected_table}' to be ACTIVE but not found in: {actual_tables}"


@then('the table is "DELETING" and write operations will fail')
def lambda_s3tables_table_is_deleting_then():
    pytest.skip("Cannot observe S3 Tables table DELETING state in lws")


@then('the invocation is "IN_PROGRESS"')
def lambda_s3tables_invocation_is_in_progress_then():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@then('the invocation is "FAILED" with a ResourceNotFoundException')
def lambda_s3tables_invocation_failed_resource_not_found():
    pytest.skip("Cannot trigger Lambda->S3Tables invocation failure in lws")


@then('the record "EXISTS" and the invocation is "SUCCESS"')
def lambda_s3tables_record_exists_invocation_success():
    pytest.skip("Cannot trigger internal Lambda->S3Tables write in lws")
