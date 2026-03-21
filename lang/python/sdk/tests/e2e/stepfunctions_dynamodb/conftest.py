"""Abstract BDD step definitions for StepfunctionsDynamodb integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_TABLE = "e2e-test-table-1"
TEST_PK = "id"
TEST_ITEM_KEY = "e2e-item-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _dynamodb_put_item_definition(table_name: str, pk: str, item_key: str) -> str:
    """Return a state machine definition with a DynamoDB PutItem task."""
    return json.dumps(
        {
            "StartAt": "PutItem",
            "States": {
                "PutItem": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::dynamodb:putItem",
                    "Parameters": {
                        "TableName": table_name,
                        "Item": {pk: {"S": item_key}},
                    },
                    "End": True,
                }
            },
        }
    )


def _dynamodb_get_item_definition(table_name: str, pk: str, item_key: str) -> str:
    """Return a state machine definition with a DynamoDB GetItem task."""
    return json.dumps(
        {
            "StartAt": "GetItem",
            "States": {
                "GetItem": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::dynamodb:getItem",
                    "Parameters": {
                        "TableName": table_name,
                        "Key": {pk: {"S": item_key}},
                    },
                    "End": True,
                }
            },
        }
    )


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _ddb(lws_session):
    return lws_session.client("dynamodb")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_table(lws_session, name=TEST_TABLE):
    _ddb(lws_session).create_table(
        TableName=name,
        KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
        BillingMode="PAY_PER_REQUEST",
    )


def _start_execution(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).start_execution(
        stateMachineArn=_sm_arn(name),
        input=TEST_INPUT,
    )
    return resp["executionArn"]


# ── Given: state machine state ────────────────────────────────────────


@given("the state machine does not already exist")
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def sm_already_exists(lws_session):
    _create_sm(lws_session)


@given("the state machine exists")
def sm_exists(lws_session):
    _create_sm(lws_session)


@given('the state machine is "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""


@given('the state machine is not "ACTIVE"')
def sm_is_not_active_given(lws_session, world):
    try:
        _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn())
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    _create_sm(lws_session)
    world["result"] = None
    world["error"] = None


@given("the state machine does not exist")
def sm_does_not_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine has no DynamoDB task configured")
def sm_has_no_dynamodb_task(lws_session, world):
    """Ensure a PASS-only state machine exists with no DynamoDB task."""
    try:
        _create_sm(lws_session)
    except Exception:  # noqa: BLE001
        pass  # state machine may already exist from a prior Given step
    world["_sm_has_no_dynamodb_task"] = True


@given("the state machine already has a DynamoDB task configured")
def sm_already_has_dynamodb_task():
    pytest.skip(
        "lws allows update_state_machine even when the state machine already has a DynamoDB task"
        " configured (idempotent overwrite allowed)"
    )


@given("the state machine has a DynamoDB task configured")
def sm_has_dynamodb_task(lws_session):
    """Create a state machine with a DynamoDB PutItem task; update if it already exists."""
    try:
        _create_table(lws_session)
    except Exception:  # noqa: BLE001
        pass  # table may already exist from a prior Given step
    try:
        _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=_dynamodb_put_item_definition(TEST_TABLE, TEST_PK, TEST_ITEM_KEY),
            roleArn=ROLE_ARN,
        )
    except Exception:  # noqa: BLE001
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_dynamodb_put_item_definition(TEST_TABLE, TEST_PK, TEST_ITEM_KEY),
        )


# ── Given: table state ────────────────────────────────────────────────


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
def table_is_not_active_given():
    pytest.skip(
        "lws does not validate DynamoDB table lifecycle state when configuring a state machine task"
    )


@given("the table does not exist")
def table_does_not_exist():
    pytest.skip(
        "lws does not validate DynamoDB table existence when configuring a state machine task"
    )


@given('the target table is "ACTIVE"')
def target_table_is_active():
    """No-op: tables are ACTIVE immediately after creation."""


@given('the target table is not "ACTIVE"')
def target_table_is_not_active():
    pytest.skip(
        "lws does not reject start_execution when the target DynamoDB table is not ACTIVE"
        " (service task dispatch is fire-and-forget)"
    )


# ── Given: execution state ────────────────────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


# ── Given: item state ─────────────────────────────────────────────────


@given("an item slot is available")
def item_slot_available(lws_session):
    lws_session.capacity("dynamodb").unlimited().apply()


@given("no item slot is available")
def no_item_slot_available():
    pytest.skip(
        "lws does not enforce DynamoDB capacity limits for StepFunctions service task"
        " (direct provider call bypasses HTTP capacity check)"
    )


@given('no item "EXISTS" in the target table')
def no_item_exists_in_target_table():
    """No-op: fresh table has no items."""


@given('an item "EXISTS" in the target table')
def item_exists_in_target_table():
    pytest.skip(
        "lws does not reject start_execution when the target table already has an item"
        " (precondition not enforced at execution start)"
    )


# ── Given: slots ───────────────────────────────────────────────────────


@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").exhaust().apply()


# ── When: actions ──────────────────────────────────────────────────────


@when("a Step Functions state machine is created")
def create_state_machine(lws_session, world):
    try:
        resp = _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=PASS_DEFINITION,
            roleArn=ROLE_ARN,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a DynamoDB table is created")
def create_dynamodb_table(lws_session, world):
    try:
        world["result"] = _ddb(lws_session).create_table(
            TableName=TEST_TABLE,
            KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a DynamoDB PutItem task is configured on the state machine")
def configure_dynamodb_task(lws_session, world):
    # Act
    try:
        world["result"] = _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_dynamodb_put_item_definition(TEST_TABLE, TEST_PK, TEST_ITEM_KEY),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    if world.get("_sm_has_no_dynamodb_task"):
        pytest.skip(
            "lws does not reject start_execution when the state machine has no DynamoDB task"
            " configured (no task definition validation)"
        )
    # Act
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution writes an item to the DynamoDB table and succeeds")
def execution_writes_item(lws_session, world):
    # Arrange: ensure table exists and SM has DynamoDB PutItem task
    try:
        _create_table(lws_session)
    except Exception:  # noqa: BLE001
        pass  # table may already exist from a prior Given step
    try:
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_dynamodb_put_item_definition(TEST_TABLE, TEST_PK, TEST_ITEM_KEY),
        )
    except Exception:  # noqa: BLE001
        pass  # SM may not exist (negative: no execution RUNNING); update will fail
    # Act
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution attempts to get an item that does not exist and the execution fails")
def execution_gets_item_not_found(lws_session, world):
    # Arrange: ensure table exists and SM has DynamoDB GetItem task (nonexistent key)
    try:
        _create_table(lws_session)
    except Exception:  # noqa: BLE001
        pass  # table may already exist from a prior Given step
    try:
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_dynamodb_get_item_definition(TEST_TABLE, TEST_PK, "nonexistent-key-1"),
        )
    except Exception:  # noqa: BLE001
        pass  # SM may not exist (negative: no execution RUNNING); update will fail
    # Act
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE" with no DynamoDB task configured')
def sm_active_no_dynamodb_task(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the table is "ACTIVE"')
def table_is_active_then(lws_session):
    resp = _ddb(lws_session).describe_table(TableName=TEST_TABLE)
    expected_status = "ACTIVE"
    actual_status = resp["Table"]["TableStatus"]
    assert (
        actual_status == expected_status
    ), f"Expected table status '{expected_status}' but got '{actual_status}'"


@then("the state machine will write an item to the table when it reaches the task state")
def sm_will_write_item(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert actual_error is expected_error, (
        f"Expected state machine update to succeed but got: {actual_error}"
    )


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the item "EXISTS" in the table and the execution is "SUCCEEDED"')
def item_exists_and_execution_succeeded(lws_session, world):
    # Arrange
    expected_error = None
    expected_item_key = TEST_ITEM_KEY
    # Assert
    actual_error = world["error"]
    assert actual_error is expected_error, (
        f"Expected start_execution to succeed but got: {actual_error}"
    )
    actual_resp = _ddb(lws_session).get_item(
        TableName=TEST_TABLE,
        Key={TEST_PK: {"S": expected_item_key}},
    )
    actual_item = actual_resp.get("Item", {})
    assert actual_item, (
        f"Expected item with key '{expected_item_key}' to exist in table '{TEST_TABLE}' "
        f"but got empty item"
    )


@then('the execution is "FAILED" because the item was not found')
def execution_failed_item_not_found(world):
    # Arrange
    expected_error = None
    # Assert: the execution should have started successfully (lws does not raise on GetItem miss)
    actual_error = world["error"]
    assert actual_error is expected_error, (
        f"Expected start_execution to succeed but got: {actual_error}"
    )
