"""Abstract BDD step definitions for StepfunctionsCognito integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_POOL = "e2e-test-pool-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _cognito(lws_session):
    return lws_session.client("cognito-idp")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_pool(lws_session, name=TEST_POOL):
    resp = _cognito(lws_session).create_user_pool(PoolName=name)
    return resp["UserPool"]["Id"]


def _get_pool_id(lws_session, name=TEST_POOL):
    resp = _cognito(lws_session).list_user_pools(MaxResults=60)
    for pool in resp.get("UserPools", []):
        if pool["Name"] == name:
            return pool["Id"]
    return None


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


# ── Given: user pool state ────────────────────────────────────────────


@given("the pool does not already exist")
def pool_not_already_exist():
    """No-op: fresh state has no user pools."""


@given("the pool already exists")
def pool_already_exists(lws_session):
    _create_pool(lws_session)


@given("the pool exists")
def pool_exists(lws_session):
    _create_pool(lws_session)


@given('the pool is "ACTIVE"')
def pool_is_active_given():
    """No-op: Cognito user pools are active immediately after creation."""


@given("the pool does not exist")
def pool_does_not_exist():
    """No-op: fresh state has no user pools."""


@given('the pool does not exist or is "DELETED"')
def pool_not_exist_or_deleted():
    """No-op: fresh state has no user pools."""


@given('the pool is already "DELETED"')
def pool_is_already_deleted(lws_session, world):
    try:
        pool_id = _create_pool(lws_session)
    except Exception:  # noqa: BLE001
        pool_id = _get_pool_id(lws_session)
    if pool_id:
        lws_session.lifecycle("cognito-idp").delete_dwell_ms(5000).apply()
        try:
            _cognito(lws_session).delete_user_pool(UserPoolId=pool_id)
        except Exception:  # noqa: BLE001
            pass
    world["result"] = None
    world["error"] = None


@given('the pool is "DELETED"')
def pool_is_deleted_given():
    """No-op: fresh state has no user pools (simulates deleted pool)."""


@given('the pool is not "DELETED"')
def pool_is_not_deleted_given(lws_session):
    _create_pool(lws_session)


# ── Given: execution state ────────────────────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available():
    pytest.skip("Cannot exhaust execution slot limit")


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


@when("a Cognito user pool is created")
def create_user_pool(lws_session, world):
    try:
        resp = _cognito(lws_session).create_user_pool(PoolName=TEST_POOL)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a Cognito user pool is deleted")
def delete_user_pool(lws_session, world):
    try:
        pool_id = _get_pool_id(lws_session)
        if pool_id is None:
            raise ClientError(
                {"Error": {"Code": "ResourceNotFoundException", "Message": "Pool not found"}},
                "DeleteUserPool",
            )
        resp = _cognito(lws_session).delete_user_pool(UserPoolId=pool_id)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
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


@when('a running execution calls an "ACTIVE" Cognito user pool and the task succeeds')
def execution_calls_active_pool(world):
    pytest.skip("Cannot trigger internal execution step that calls Cognito in lws")


@when("a running execution fails because the Cognito user pool has been deleted")
def execution_fails_pool_deleted(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to deleted Cognito pool in lws"
    )


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the pool is "ACTIVE"')
def pool_is_active_then(lws_session):
    resp = _cognito(lws_session).list_user_pools(MaxResults=60)
    expected_pool_name = TEST_POOL
    actual_pool_names = [p["Name"] for p in resp.get("UserPools", [])]
    assert (
        expected_pool_name in actual_pool_names
    ), f"Expected pool '{expected_pool_name}' to exist but got: {actual_pool_names}"


@then('the pool is "DELETED" and "SDK" task calls targeting it will fail')
def pool_is_deleted_then(lws_session):
    pool_id = _get_pool_id(lws_session)
    expected_pool_id = None
    actual_pool_id = pool_id
    assert (
        actual_pool_id is expected_pool_id
    ), f"Expected pool '{TEST_POOL}' to be deleted but it still exists with id: {actual_pool_id}"


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution Cognito task success in lws")


@then('the execution is "FAILED" with a ResourceNotFoundException')
def execution_failed_resource_not_found():
    pytest.skip("Cannot observe internal execution Cognito task failure in lws")
