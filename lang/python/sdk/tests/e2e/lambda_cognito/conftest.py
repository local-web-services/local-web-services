"""Abstract BDD step definitions for LambdaCognito integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_POOL = "e2e-test-pool-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _cognito(lws_session):
    return lws_session.client("cognito-idp")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_pool(lws_session, name=TEST_POOL):
    resp = _cognito(lws_session).create_user_pool(PoolName=name)
    return resp["UserPool"]["Id"]


def _pool_id(lws_session, name=TEST_POOL):
    resp = _cognito(lws_session).list_user_pools(MaxResults=10)
    for pool in resp.get("UserPools", []):
        if pool["Name"] == name:
            return pool["Id"]
    return None


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


# ── Given: pool state ──────────────────────────────────────────────────


@given("the pool does not already exist")
def pool_not_already_exist():
    """No-op: fresh state has no pools."""


@given("the pool already exists")
def pool_already_exists(lws_session):
    _create_pool(lws_session)


@given("the pool exists")
def pool_exists(lws_session):
    _create_pool(lws_session)


@given('the pool is "ACTIVE"')
def pool_is_active_given():
    """No-op: pools are ACTIVE immediately after creation."""


@given('the pool is already "DELETED"')
def pool_is_already_deleted(lws_session, world):
    pool_id = _pool_id(lws_session)
    if pool_id:
        _cognito(lws_session).delete_user_pool(UserPoolId=pool_id)
    world["result"] = None
    world["error"] = None


@given("the pool does not exist")
def pool_does_not_exist():
    """No-op: fresh state has no pools."""


@given('the pool does not exist or is "DELETED"')
def pool_not_exist_or_deleted():
    """No-op: fresh state has no pools."""


@given('the pool is "DELETED"')
def pool_is_deleted_given():
    """No-op: fresh state has no pools (simulates deleted pool)."""


@given('the pool is not "DELETED"')
def pool_is_not_deleted_given(lws_session):
    _create_pool(lws_session)


# ── Given: invocation state ────────────────────────────────────────────


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


@when("a Cognito user pool is created")
def create_cognito_user_pool(lws_session, world):
    try:
        resp = _create_pool(lws_session)
        world["result"] = {"UserPoolId": resp}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Cognito user pool is deleted")
def delete_cognito_user_pool(lws_session, world):
    try:
        pool_id = _pool_id(lws_session)
        _cognito(lws_session).delete_user_pool(UserPoolId=pool_id)
        world["result"] = {"UserPoolId": pool_id}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to call Cognito because the pool has been deleted")
def invocation_fails_pool_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds')
def invocation_succeeds_cognito(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the pool is "ACTIVE"')
def pool_is_active_then(lws_session):
    pool_id = _pool_id(lws_session)
    resp = _cognito(lws_session).describe_user_pool(UserPoolId=pool_id)
    expected_statuses = ("Active", "Enabled")
    actual_status = resp["UserPool"]["Status"]
    assert (
        actual_status in expected_statuses
    ), f"Expected pool status in {expected_statuses!r} but got '{actual_status}'"


@then('the pool is "DELETED" and Lambda calls targeting it will fail')
def pool_is_deleted_then(lws_session):
    pool_id = _pool_id(lws_session)
    assert pool_id is None, f"Expected pool to be deleted but found pool with id '{pool_id}'"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a ResourceNotFoundException')
def invocation_failed_resource_not_found(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")
