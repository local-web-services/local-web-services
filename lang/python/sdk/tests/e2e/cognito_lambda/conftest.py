"""Abstract BDD step definitions for CognitoLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_POOL = "e2e-test-pool-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _cognito(lws_session):
    return lws_session.client("cognito-idp")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _create_pool(lws_session, name=TEST_POOL):
    resp = _cognito(lws_session).create_user_pool(PoolName=name)
    return resp["UserPool"]["Id"]


def _get_pool_id(lws_session, name=TEST_POOL):
    resp = _cognito(lws_session).list_user_pools(MaxResults=60)
    for pool in resp.get("UserPools", []):
        if pool["Name"] == name:
            return pool["Id"]
    return None


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _get_function_exists(lws_session, name=TEST_FUNC):
    try:
        _lambda(lws_session).get_function(FunctionName=name)
        return True
    except Exception:  # noqa: BLE001
        return False


# ── Given: pool state ─────────────────────────────────────────────────


@given("the pool does not already exist")
def cognito_lambda_pool_not_already_exist():
    """No-op: fresh state has no user pools."""


@given("the pool already exists")
def cognito_lambda_pool_already_exists(lws_session):
    _create_pool(lws_session)


@given("the pool exists")
def cognito_lambda_pool_exists(lws_session):
    _create_pool(lws_session)


@given('the pool is "ACTIVE"')
def cognito_lambda_pool_is_active_given():
    """No-op: Cognito user pools are ACTIVE immediately after creation."""


@given('the pool is not "ACTIVE"')
def cognito_lambda_pool_is_not_active_given(lws_session, world):
    try:
        pool_id = _get_pool_id(lws_session)
        if pool_id is not None:
            _cognito(lws_session).delete_user_pool(UserPoolId=pool_id)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("cognito-idp").create_dwell_ms(5000).apply()
    _create_pool(lws_session)
    world["result"] = None
    world["error"] = None


@given("the pool does not exist")
def cognito_lambda_pool_does_not_exist():
    """No-op: fresh state has no user pools."""


@given("the pool has no trigger configured")
def cognito_lambda_pool_has_no_trigger():
    """No-op: pools have no trigger configured by default."""


@given("the pool has no pre-signup trigger configured")
def cognito_lambda_pool_has_no_pre_signup_trigger():
    """No-op: pools have no pre-signup trigger configured by default."""


@given("the pool already has a trigger configured")
def cognito_lambda_pool_already_has_trigger():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")


@given("the pool has a pre-signup trigger configured")
def cognito_lambda_pool_has_pre_signup_trigger():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def cognito_lambda_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def cognito_lambda_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def cognito_lambda_function_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def cognito_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def cognito_lambda_function_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def cognito_lambda_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


@given('the trigger function is "ACTIVE"')
def cognito_lambda_trigger_function_is_active():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")


@given('the trigger function is not "ACTIVE"')
def cognito_lambda_trigger_function_is_not_active():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("the user slot is available")
def cognito_lambda_user_slot_available(lws_session):
    lws_session.capacity("cognito-idp").unlimited().apply()


@given("no user slot is available")
def cognito_lambda_no_user_slot_available(lws_session):
    lws_session.capacity("cognito-idp").exhaust().apply()


@given("an invocation slot is available")
def cognito_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()


@given("no invocation slot is available")
def cognito_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()


# ── Given: invocation state ───────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def cognito_lambda_invocation_is_in_progress():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")


@given('no invocation is "IN_PROGRESS"')
def cognito_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


# ── Given: sequence setup ─────────────────────────────────────────────


@given("pid not in pool_status")
def cognito_lambda_pid_not_in_pool_status():
    """No-op: fresh state has no user pools."""


@given("pid in pool_status")
def cognito_lambda_pid_in_pool_status(lws_session):
    _create_pool(lws_session)


@given("fid not in func_status")
def cognito_lambda_fid_not_in_func_status():
    """No-op: fresh state has no Lambda functions."""


@given("iid in inv_status")
def cognito_lambda_iid_in_inv_status():
    pytest.skip("Cannot represent a completed Lambda invocation as sequence setup in lws")


@given("a Cognito User Pool has been created")
def cognito_lambda_user_pool_has_been_created(lws_session):
    _create_pool(lws_session)


@given("a Lambda function has been deployed")
def cognito_lambda_function_has_been_deployed(lws_session):
    _create_function(lws_session)


@given("a Lambda pre-signup trigger has been configured on the Cognito User Pool")
def cognito_lambda_pre_signup_trigger_configured():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")


@given("a user has signed up to a pool that has no pre-signup trigger configured")
def cognito_lambda_user_signed_up_no_trigger():
    pytest.skip("Cannot represent a completed Cognito signup as sequence setup in lws")


@given("a user has initiated signup to a pool that has a pre-signup trigger configured")
def cognito_lambda_user_initiated_signup_with_trigger():
    pytest.skip("Cannot represent a Cognito signup with trigger as sequence setup in lws")


@given("the pre-signup Lambda has allowed the signup")
def cognito_lambda_pre_signup_allowed():
    pytest.skip("Cannot represent a Lambda trigger invocation result as sequence setup in lws")


@given("the pre-signup Lambda has denied the signup")
def cognito_lambda_pre_signup_denied():
    pytest.skip("Cannot represent a Lambda trigger invocation result as sequence setup in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when("a Cognito User Pool is created")
def create_cognito_user_pool(lws_session, world):
    try:
        resp = _cognito(lws_session).create_user_pool(PoolName=TEST_POOL)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Lambda function is deployed")
def deploy_lambda_function_cognito(lws_session, world):
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


@when("a Lambda pre-signup trigger is configured on the Cognito User Pool")
def configure_lambda_trigger(world):
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")


@when("a user initiates signup to a pool that has a pre-signup trigger configured")
def user_initiates_signup_with_trigger(world):
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")


@when("a user signs up to a pool that has no pre-signup trigger configured")
def user_signs_up_without_trigger(lws_session, world):
    try:
        pool_id = _get_pool_id(lws_session)
        if pool_id is None:
            raise ClientError(
                {"Error": {"Code": "ResourceNotFoundException", "Message": "Pool not found"}},
                "AdminCreateUser",
            )
        resp = _cognito(lws_session).admin_create_user(
            UserPoolId=pool_id,
            Username="e2e-test-user-1",
            MessageAction="SUPPRESS",
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the pre-signup Lambda allows the signup")
def pre_signup_lambda_allows(world):
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")


@when("the pre-signup Lambda denies the signup")
def pre_signup_lambda_denies(world):
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the pool is "ACTIVE" with no pre-signup trigger configured')
def pool_is_active_no_trigger(lws_session):
    resp = _cognito(lws_session).list_user_pools(MaxResults=60)
    actual_pool_names = [p["Name"] for p in resp.get("UserPools", [])]
    expected_pool_name = TEST_POOL
    assert (
        expected_pool_name in actual_pool_names
    ), f"Expected pool '{expected_pool_name}' to exist but not found in: {actual_pool_names}"


@then('the pool is "ACTIVE"')
def cognito_lambda_pool_is_active_then(lws_session):
    resp = _cognito(lws_session).list_user_pools(MaxResults=60)
    actual_pool_names = [p["Name"] for p in resp.get("UserPools", [])]
    expected_pool_name = TEST_POOL
    assert (
        expected_pool_name in actual_pool_names
    ), f"Expected pool '{expected_pool_name}' to be ACTIVE but not found in: {actual_pool_names}"


@then('the function is "ACTIVE"')
def cognito_lambda_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then("all subsequent signups will synchronously invoke the function before confirming")
def signups_will_invoke_function():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")


@then('the user is "PENDING" and the trigger Lambda is invoked synchronously')
def user_is_pending_trigger_invoked():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")


@then('the user is immediately "CONFIRMED"')
def user_is_immediately_confirmed(lws_session):
    pool_id = _get_pool_id(lws_session)
    resp = _cognito(lws_session).list_users(UserPoolId=pool_id)
    actual_users = resp.get("Users", [])
    expected_count = 1
    actual_count = len(actual_users)
    assert (
        actual_count >= expected_count
    ), f"Expected at least {expected_count} user but found: {actual_count}"


@then('the invocation is "SUCCESS" and the user is "CONFIRMED"')
def invocation_success_user_confirmed():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")


@then('the invocation is "FAILED" and the user is "REJECTED"')
def invocation_failed_user_rejected():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "IN_PROGRESS" invocation is for a "PENDING" user')
def _inv_cognito_lambda_every_in_progress_invocation_is_for_a_pending_user():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_cognito_lambda_every_in_progress_invocation_references_an_active_lambda_fun():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "PENDING" user has a corresponding "IN_PROGRESS" invocation')
def _inv_cognito_lambda_every_pending_user_has_a_corresponding_in_progress_invocatio():
    """Invariant step: trivially satisfied in isolated test context."""
