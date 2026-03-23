"""Abstract BDD step definitions for DynamodbLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_TABLE = "e2e-test-table-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


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


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
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
def dynamodb_lambda_table_has_stream():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@given("the table does not have a stream enabled")
def dynamodb_lambda_table_has_no_stream():
    """No-op: tables have no stream by default."""


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


@given("the function does not exist")
def dynamodb_lambda_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


# ── Given: event source mapping state ────────────────────────────────


@given("the event source mapping does not already exist")
def dynamodb_lambda_esm_not_already_exist():
    """No-op: fresh state has no event source mappings."""


@given("the event source mapping already exists")
def dynamodb_lambda_esm_already_exists():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@given("the event source mapping exists")
def dynamodb_lambda_esm_exists():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@given('the event source mapping is "ENABLED"')
def dynamodb_lambda_esm_is_enabled():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@given('the event source mapping is not "ENABLED"')
def dynamodb_lambda_esm_is_not_enabled():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@given("the event source mapping does not exist")
def dynamodb_lambda_esm_does_not_exist():
    """No-op: fresh state has no event source mappings."""


@given('the mapped function is "ACTIVE"')
def dynamodb_lambda_mapped_function_is_active():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@given('the mapped function is not "ACTIVE"')
def dynamodb_lambda_mapped_function_is_not_active():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@given('an "AVAILABLE" record exists in the mapped table\'s stream')
def dynamodb_lambda_available_record_exists():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


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
def dynamodb_lambda_invocation_is_in_progress():
    pytest.skip("Cannot trigger DynamoDB->Lambda invocation in lws")


@given('no invocation is "IN_PROGRESS"')
def dynamodb_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


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
def create_event_source_mapping(world):
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@when("a change to the DynamoDB table produces a stream record")
def table_change_produces_record(world):
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@when("the event source mapping polls the stream and invokes the Lambda function with the record")
def esm_polls_and_invokes(world):
    pytest.skip("Cannot trigger DynamoDB->Lambda invocation in lws")


@when("the Lambda invocation processes the stream record successfully")
def lambda_invocation_succeeds(world):
    pytest.skip("Cannot trigger DynamoDB->Lambda invocation in lws")


@when("the Lambda invocation fails and the stream record is retried")
def lambda_invocation_fails(world):
    pytest.skip("Cannot trigger DynamoDB->Lambda invocation in lws")


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
def esm_is_enabled():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@then('a change record is "AVAILABLE" for the event source mapping to process')
def change_record_available():
    pytest.skip("Cannot configure DynamoDB stream trigger for Lambda in lws")


@then('the record is being processed and a Lambda invocation is "IN_PROGRESS"')
def record_being_processed():
    pytest.skip("Cannot trigger DynamoDB->Lambda invocation in lws")


@then('the invocation is "SUCCESS" and the record is "PROCESSED"')
def invocation_success_record_processed():
    pytest.skip("Cannot trigger DynamoDB->Lambda invocation in lws")


@then('the invocation is "FAILED" and the record is "AVAILABLE" again for reprocessing')
def invocation_failed_record_available():
    pytest.skip("Cannot trigger DynamoDB->Lambda invocation in lws")
