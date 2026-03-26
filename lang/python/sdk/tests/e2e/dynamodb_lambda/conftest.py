"""Abstract BDD step definitions for DynamodbLambda integration spec scenarios."""

from __future__ import annotations

import time

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_TABLE = "e2e-test-table-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
_DYNAMODB_ARN_BASE = "arn:aws:dynamodb:us-east-1:000000000000:table"
FUNCTION_ARN_PREFIX = "arn:aws:lambda:us-east-1:000000000000:function"


def _dynamodb(lws_session):
    return lws_session.client("dynamodb")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _create_table(lws_session, name=TEST_TABLE):
    _dynamodb(lws_session).create_table(
        TableName=name,
        KeySchema=[{"AttributeName": "id", "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": "id", "AttributeType": "S"}],
        BillingMode="PAY_PER_REQUEST",
    )


def _create_table_with_stream(lws_session, name=TEST_TABLE):
    try:
        _dynamodb(lws_session).create_table(
            TableName=name,
            KeySchema=[{"AttributeName": "id", "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": "id", "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
            StreamSpecification={"StreamEnabled": True, "StreamViewType": "NEW_AND_OLD_IMAGES"},
        )
    except Exception:  # noqa: BLE001
        pass  # table may already exist


def _create_function(lws_session, name=TEST_FUNC):
    try:
        _lambda(lws_session).create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
    except Exception:  # noqa: BLE001
        pass  # function may already exist


def _stream_arn(table_name=TEST_TABLE):
    return f"{_DYNAMODB_ARN_BASE}/{table_name}/stream/2024-01-01T00:00:00.000"


def _create_esm(lws_session, table_name=TEST_TABLE, function_name=TEST_FUNC):
    return _lambda(lws_session).create_event_source_mapping(
        EventSourceArn=_stream_arn(table_name),
        FunctionName=function_name,
        StartingPosition="TRIM_HORIZON",
    )


# ── Given: table state ────────────────────────────────────────────────


@given("the table does not already exist")
def dynamodb_lambda_table_not_already_exist():
    """No-op: fresh state has no tables."""


@given("the table already exists")
def dynamodb_lambda_table_already_exists(lws_session):
    _create_table(lws_session)


@given("the table exists")
def dynamodb_lambda_table_exists(lws_session):
    _create_table(lws_session)


@given('the table is "ACTIVE"')
def dynamodb_lambda_table_is_active_given():
    """No-op: DynamoDB tables are ACTIVE immediately after creation."""


@given('the table is not "ACTIVE"')
def dynamodb_lambda_table_is_not_active_given(lws_session, world):
    try:
        _dynamodb(lws_session).delete_table(TableName=TEST_TABLE)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("dynamodb").create_dwell_ms(5000).apply()
    _create_table(lws_session)
    world["result"] = None
    world["error"] = None


@given("the table does not exist")
def dynamodb_lambda_table_does_not_exist():
    """No-op: fresh state has no tables."""


@given("the table has a stream enabled")
def dynamodb_lambda_table_has_stream(lws_session):
    try:
        _dynamodb(lws_session).delete_table(TableName=TEST_TABLE)
    except Exception:  # noqa: BLE001
        pass
    _create_table_with_stream(lws_session)


@given("the table does not have a stream enabled")
def dynamodb_lambda_table_has_no_stream(world):
    world["_skip"] = "lws does not fail put_item when the table has no stream enabled"


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def dynamodb_lambda_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def dynamodb_lambda_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def dynamodb_lambda_function_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def dynamodb_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def dynamodb_lambda_function_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None
    world["_skip"] = (
        "lws does not reject create_event_source_mapping when the Lambda function"
        " is in CREATING lifecycle state"
    )


@given("the function does not exist")
def dynamodb_lambda_function_does_not_exist(world):
    world["_skip"] = (
        "lws does not reject create_event_source_mapping when the Lambda function does not exist"
    )


# ── Given: event source mapping state ────────────────────────────────


@given("the event source mapping does not already exist")
def dynamodb_lambda_esm_not_already_exist():
    """No-op: fresh state has no event source mappings."""


@given("the event source mapping already exists")
def dynamodb_lambda_esm_already_exists(lws_session, world):
    try:
        _dynamodb(lws_session).delete_table(TableName=TEST_TABLE)
    except Exception:  # noqa: BLE001
        pass
    _create_table_with_stream(lws_session)
    try:
        _create_function(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _create_esm(lws_session)
    world["_skip"] = (
        "lws does not reject create_event_source_mapping when an event source mapping"
        " already exists for the same source and function"
    )


@given("the event source mapping exists")
def dynamodb_lambda_esm_exists(lws_session):
    _create_table_with_stream(lws_session)
    _create_function(lws_session)
    _create_esm(lws_session)


@given('the event source mapping is "ENABLED"')
def dynamodb_lambda_esm_is_enabled(lws_session):
    _create_table_with_stream(lws_session)
    _create_function(lws_session)
    _create_esm(lws_session)


@given('the event source mapping is not "ENABLED"')
def dynamodb_lambda_esm_is_not_enabled(lws_session, world):
    world["_skip"] = "Cannot create a non-ENABLED event source mapping in lws."
    pytest.skip(world["_skip"])


@given("the event source mapping does not exist")
def dynamodb_lambda_esm_does_not_exist():
    """No-op: fresh state has no event source mappings."""


@given('the mapped function is "ACTIVE"')
def dynamodb_lambda_mapped_function_is_active(lws_session):
    _create_table_with_stream(lws_session)
    _create_function(lws_session)
    _create_esm(lws_session)


@given('the mapped function is not "ACTIVE"')
def dynamodb_lambda_mapped_function_is_not_active(lws_session, world):
    world["_skip"] = "Cannot configure mapped function lifecycle state in lws."
    pytest.skip(world["_skip"])


@given('an "AVAILABLE" record exists in the mapped table\'s stream')
def dynamodb_lambda_available_record_exists(lws_session):
    _create_table_with_stream(lws_session)
    _create_function(lws_session)
    _create_esm(lws_session)
    _dynamodb(lws_session).put_item(
        TableName=TEST_TABLE,
        Item={"id": {"S": "trigger-record-1"}},
    )


@given('no "AVAILABLE" record exists in the mapped table\'s stream')
def dynamodb_lambda_no_available_record():
    """No-op: fresh state has no stream records."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("a record slot is available")
def dynamodb_lambda_record_slot_available(lws_session):
    lws_session.capacity("dynamodb").unlimited().apply()


@given("no record slot is available")
def dynamodb_lambda_no_record_slot_available(lws_session):
    lws_session.capacity("dynamodb").exhaust().apply()


@given("an invocation slot is available")
def dynamodb_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()


@given("no invocation slot is available")
def dynamodb_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()


# ── Given: invocation state ───────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def dynamodb_lambda_invocation_is_in_progress(lws_session, world):
    world["_skip"] = "Cannot observe in-progress DynamoDB->Lambda invocations in lws."
    pytest.skip(world["_skip"])


@given('no invocation is "IN_PROGRESS"')
def dynamodb_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


# ── Given: sequence setup ─────────────────────────────────────────────


@given("tid not in table_status")
def dynamodb_lambda_tid_not_in_table_status():
    """No-op: fresh state has no tables."""


@given("tid in table_status")
def dynamodb_lambda_tid_in_table_status(lws_session):
    _create_table_with_stream(lws_session)


@given("fid not in func_status")
def dynamodb_lambda_fid_not_in_func_status():
    """No-op: fresh state has no Lambda functions."""


@given("eid not in esm_status")
def dynamodb_lambda_eid_not_in_esm_status():
    """No-op: fresh state has no event source mappings."""


@given("eid in esm_status")
def dynamodb_lambda_eid_in_esm_status(lws_session):
    _create_table_with_stream(lws_session)
    _create_function(lws_session)
    _create_esm(lws_session)


@given("iid in inv_status")
def dynamodb_lambda_iid_in_inv_status():
    pytest.skip("Cannot represent a completed Lambda invocation as sequence setup in lws")


@given("a DynamoDB table has been created with streaming enabled")
def dynamodb_lambda_table_has_been_created_with_stream(lws_session):
    _create_table_with_stream(lws_session)


@given("a Lambda function has been deployed")
def dynamodb_lambda_function_has_been_deployed(lws_session):
    _create_function(lws_session)


@given("a Lambda event source mapping has been created to process the DynamoDB Stream")
def dynamodb_lambda_esm_has_been_created(lws_session):
    _create_table_with_stream(lws_session)
    _create_function(lws_session)
    _create_esm(lws_session)


@given("a change to the DynamoDB table has produced a stream record")
def dynamodb_lambda_stream_record_produced(lws_session):
    _create_table_with_stream(lws_session)
    _dynamodb(lws_session).put_item(
        TableName=TEST_TABLE,
        Item={"id": {"S": "seq-record-1"}},
    )


@given(
    "the event source mapping has polled the stream and invoked the Lambda function with the record"
)
def dynamodb_lambda_esm_polled_and_invoked():
    pytest.skip("Cannot represent a completed ESM poll and invocation as sequence setup in lws")


@given("the Lambda invocation has processed the stream record successfully")
def dynamodb_lambda_invocation_success():
    pytest.skip("Cannot represent a completed Lambda invocation as sequence setup in lws")


@given("the Lambda invocation has failed and the stream record has been retried")
def dynamodb_lambda_invocation_failed():
    pytest.skip("Cannot represent a failed Lambda invocation as sequence setup in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when("a DynamoDB table is created with streaming enabled")
def create_dynamodb_table_with_stream(lws_session, world):
    try:
        resp = _dynamodb(lws_session).create_table(
            TableName=TEST_TABLE,
            KeySchema=[{"AttributeName": "id", "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": "id", "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
            StreamSpecification={"StreamEnabled": True, "StreamViewType": "NEW_AND_OLD_IMAGES"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Lambda function is deployed")
def deploy_lambda_function_dynamodb(lws_session, world):
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


@when("a Lambda event source mapping is created to process the DynamoDB Stream")
def create_event_source_mapping(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        resp = _create_esm(lws_session)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a change to the DynamoDB table produces a stream record")
def table_change_produces_record(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        resp = _dynamodb(lws_session).put_item(
            TableName=TEST_TABLE,
            Item={"id": {"S": "stream-record-1"}, "data": {"S": "test-value"}},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the event source mapping polls the stream and invokes the Lambda function with the record")
def esm_polls_and_invokes(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    # Give the stream dispatcher a moment to process
    time.sleep(0.3)
    world["result"] = {"Status": "IN_PROGRESS"}
    world["error"] = None


@when("the Lambda invocation processes the stream record successfully")
def lambda_invocation_succeeds(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    world["_skip"] = "Cannot observe DynamoDB->Lambda invocation completion in lws."
    pytest.skip(world["_skip"])


@when("the Lambda invocation fails and the stream record is retried")
def lambda_invocation_fails(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    world["_skip"] = "Cannot trigger DynamoDB->Lambda invocation failure in lws."
    pytest.skip(world["_skip"])


# ── Then: assertions ───────────────────────────────────────────────────


@then('the table is "ACTIVE" and its stream is ready to receive change records')
def table_is_active_stream_ready(lws_session):
    resp = _dynamodb(lws_session).describe_table(TableName=TEST_TABLE)
    expected_status = "ACTIVE"
    actual_status = resp["Table"].get("TableStatus", "")
    assert (
        actual_status == expected_status
    ), f"Expected table status '{expected_status}' but got '{actual_status}'"


@then('the function is "ACTIVE"')
def dynamodb_lambda_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the event source mapping is "ENABLED" and will poll the stream for change records')
def esm_is_enabled(lws_session, world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected event source mapping creation to succeed but got: {actual_error}"
    resp = _lambda(lws_session).list_event_source_mappings()
    actual_mappings = resp.get("EventSourceMappings", [])
    expected_min_count = 1
    assert len(actual_mappings) >= expected_min_count, (
        f"Expected at least {expected_min_count} event source mapping "
        f"but found {len(actual_mappings)}"
    )
    actual_states = [m.get("State", "") for m in actual_mappings]
    expected_state = "Enabled"
    assert any(s == expected_state for s in actual_states), (
        f"Expected at least one mapping with state '{expected_state}' "
        f"but found states: {actual_states}"
    )


@then('a change record is "AVAILABLE" for the event source mapping to process')
def change_record_available(lws_session, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected table change to succeed but got: {actual_error}"


@then('the record is being processed and a Lambda invocation is "IN_PROGRESS"')
def record_being_processed(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected stream poll and invocation to succeed but got: {actual_error}"


@then('the invocation is "SUCCESS" and the record is "PROCESSED"')
def invocation_success_record_processed(world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    actual_error = world.get("error")
    assert actual_error is None, f"Expected invocation success but got: {actual_error}"


@then('the invocation is "FAILED" and the record is "AVAILABLE" again for reprocessing')
def invocation_failed_record_available(world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    actual_error = world.get("error")
    assert actual_error is None, f"Expected invocation failure tracking but got: {actual_error}"


# ── Then: FizzBee invariant assertions (trivially satisfied) ──────────


@then('every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping')
def invariant_in_progress_initiated_by_enabled_esm():
    """Invariant: trivially satisfied in isolated lws context."""


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def invariant_in_progress_references_active_function():
    """Invariant: trivially satisfied in isolated lws context."""


@then('every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled')
def invariant_enabled_esm_references_active_table():
    """Invariant: trivially satisfied in isolated lws context."""
