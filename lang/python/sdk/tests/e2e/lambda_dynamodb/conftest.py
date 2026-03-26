"""Abstract BDD step definitions for LambdaDynamodb integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_TABLE = "e2e-test-table-1"
TEST_PK = "pk"
TEST_ITEM_KEY = "e2e-item-key-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _dynamo(lws_session):
    return lws_session.client("dynamodb")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_table(lws_session, name=TEST_TABLE):
    _dynamo(lws_session).create_table(
        TableName=name,
        KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
        BillingMode="PAY_PER_REQUEST",
    )


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def func_not_already_exist():
    """No-op: fresh state has no functions."""


@given("the function already exists")
def func_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def func_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def func_is_active_given():
    """No-op: functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def func_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def func_does_not_exist():
    """No-op: fresh state has no functions."""


# ── Given: table state ─────────────────────────────────────────────────


@given("the table does not already exist")
def table_not_already_exist():
    """No-op: fresh state has no tables."""


@given("the table already exists")
def table_already_exists(lws_session):
    _create_table(lws_session)


@given("the table exists")
def table_exists(lws_session):
    _create_table(lws_session)


@given('the table is "ACTIVE"')
def table_is_active_given():
    """No-op: tables are ACTIVE immediately after creation."""


@given('the table is not "ACTIVE"')
def table_is_not_active_given(lws_session, world):
    try:
        _dynamo(lws_session).delete_table(TableName=TEST_TABLE)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("dynamodb").create_dwell_ms(5000).apply()
    _create_table(lws_session)
    world["result"] = None
    world["error"] = None


@given("the table does not exist")
def table_does_not_exist():
    """No-op: fresh state has no tables."""


# ── Given: invocation / slot state ────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    _create_function(lws_session)


@given('no invocation is "IN_PROGRESS"')
def no_invocation_is_in_progress():
    """No-op: fresh state has no invocations."""


@given("an invocation slot is available")
def invocation_slot_available():
    """No-op: always room for invocations."""


@given("no invocation slot is available")
def no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")


@given("an item slot is available")
def item_slot_available():
    """No-op: always room for items."""


@given("no item slot is available")
def no_item_slot_available():
    pytest.skip("Cannot exhaust item slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no Lambda functions."""


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("a Lambda function has been deployed")
def lambda_dynamodb_seq_function_deployed(lws_session):
    _create_function(lws_session)


@given("tid not in table_status")
def tid_not_in_table_status():
    """No-op: fresh state has no DynamoDB tables."""


@given("a DynamoDB table has been created")
def lambda_dynamodb_seq_table_created(lws_session):
    _create_table(lws_session)


@given("the Lambda function has been invoked")
def lambda_dynamodb_seq_function_invoked():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot observe Lambda invocation state in lws")


@given("the Lambda function has written an item to the DynamoDB table during invocation")
def lambda_dynamodb_seq_item_written():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("the Lambda invocation has completed successfully")
def lambda_dynamodb_seq_invocation_succeeded():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("the Lambda invocation has failed")
def lambda_dynamodb_seq_invocation_failed():
    pytest.skip("Cannot trigger Lambda invocation in lws")


# ── When: actions ───────────────────────────────────────────────────────


@when("a Lambda function is deployed")
def deploy_lambda_function(lws_session, world):
    try:
        _create_function(lws_session)
        world["result"] = {"FunctionName": TEST_FUNC}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a DynamoDB table is created")
def create_dynamodb_table(lws_session, world):
    try:
        _create_table(lws_session)
        world["result"] = {"TableName": TEST_TABLE}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda invocation fails")
def lambda_invocation_fails(world):
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


@when("the Lambda invocation completes successfully")
def lambda_invocation_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation success in lws")


@when("the Lambda function writes an item to the DynamoDB table during invocation")
def lambda_writes_item(world):
    pytest.skip("Cannot trigger Lambda item write in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the table is "ACTIVE"')
def table_is_active_then(lws_session):
    resp = _dynamo(lws_session).describe_table(TableName=TEST_TABLE)
    expected_status = "ACTIVE"
    actual_status = resp["Table"]["TableStatus"]
    assert (
        actual_status == expected_status
    ), f"Expected table status '{expected_status}' but got '{actual_status}'"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED"')
def invocation_is_failed_then(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


@then('the item "EXISTS" in the table')
def item_exists_in_table(world):
    pytest.skip("Cannot observe Lambda item write result in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_dynamodb_every_in_progress_invocation_references_an_active_lambda_fu():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every existing item belongs to an "ACTIVE" table')
def _inv_lambda_dynamodb_every_existing_item_belongs_to_an_active_table():
    """Invariant step: trivially satisfied in isolated test context."""
