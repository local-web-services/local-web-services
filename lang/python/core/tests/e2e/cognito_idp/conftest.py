"""BDD step definitions for Cognito IDP informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_POOL_NAME = "e2e-test-pool-1"
TEST_USERNAME = "e2e-test-user-1@example.com"
TEST_PASSWORD = "Test1234!"
TEST_TEMP_PASSWORD = "TempPass1!"


def _cognito(lws_session):
    return lws_session.client("cognito-idp")


def _get_pool_id(lws_session):
    return lws_session.client("cognito-idp").list_user_pools(MaxResults=10)["UserPools"][0]["Id"]


def _create_pool(lws_session, name=TEST_POOL_NAME):
    resp = _cognito(lws_session).create_user_pool(PoolName=name)
    return resp["UserPool"]["Id"]


# ── Given: user pool state setup ────────────────────────────────────────


@given("the user pool does not already exist")
def pool_not_already_exist():
    """No-op: fresh state has no user pools."""


@given("the user pool already exists")
def pool_already_exists(lws_session, world):
    world["pool_id"] = _create_pool(lws_session)


@given("the user pool exists")
def pool_exists(lws_session, world):
    world["pool_id"] = _create_pool(lws_session)


@given('the user pool is "ACTIVE"')
def pool_is_active_given():
    """No-op: user pools are ACTIVE immediately after creation."""


@given('the user pool is not "ACTIVE"')
def pool_is_not_active_given(lws_session, world):
    lws_session.lifecycle("cognito").create_dwell_ms(5000).apply()
    world["pool_id"] = _create_pool(lws_session)


@given("the user pool does not exist")
def pool_does_not_exist(lws_session, world):
    """Ensure the user pool does not exist by deleting it if present."""
    client = _cognito(lws_session)
    pool_id = world.get("pool_id")
    if pool_id:
        try:
            client.delete_user_pool(UserPoolId=pool_id)
        except Exception:
            pass


# ── Given: user state setup ─────────────────────────────────────────────


@given("the user does not already exist")
def user_not_already_exist():
    """No-op: fresh state has no users."""


@given("the user already exists")
def user_already_exists(lws_session, world):
    if not world.get("pool_id"):
        world["pool_id"] = _create_pool(lws_session)
    _cognito(lws_session).admin_create_user(
        UserPoolId=world["pool_id"],
        Username=TEST_USERNAME,
        TemporaryPassword=TEST_TEMP_PASSWORD,
    )
    world["username"] = TEST_USERNAME


@given("the user exists")
def user_exists(lws_session, world):
    if not world.get("pool_id"):
        world["pool_id"] = _create_pool(lws_session)
    _cognito(lws_session).admin_create_user(
        UserPoolId=world["pool_id"],
        Username=TEST_USERNAME,
        TemporaryPassword=TEST_TEMP_PASSWORD,
    )
    world["username"] = TEST_USERNAME


@given("the user does not exist")
def user_does_not_exist():
    """No-op: fresh state has no users."""


@given('the user is "FORCE_CHANGE_PASSWORD"')
def user_is_force_change_password():
    """No-op: users created via AdminCreateUser start in FORCE_CHANGE_PASSWORD by default."""


@given('the user is not "FORCE_CHANGE_PASSWORD"')
def user_is_not_force_change_password():
    pytest.skip("Cannot set user to non-FORCE_CHANGE_PASSWORD state without auth flow")


# ── When: actions ───────────────────────────────────────────────────────


@when('a "Cognito" user pool is created')
def create_user_pool(lws_session, world):
    try:
        resp = _cognito(lws_session).create_user_pool(PoolName=TEST_POOL_NAME)
        world["result"] = resp
        world["pool_id"] = resp["UserPool"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a "Cognito" user pool is deleted')
def delete_user_pool(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        world["result"] = _cognito(lws_session).delete_user_pool(UserPoolId=pool_id)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a "Cognito" user is created')
def create_user(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        resp = _cognito(lws_session).admin_create_user(
            UserPoolId=pool_id,
            Username=TEST_USERNAME,
            TemporaryPassword=TEST_TEMP_PASSWORD,
        )
        world["result"] = resp
        world["username"] = TEST_USERNAME
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a "Cognito" user is deleted')
def delete_user(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        username = world.get("username", TEST_USERNAME)
        world["result"] = _cognito(lws_session).admin_delete_user(
            UserPoolId=pool_id, Username=username
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ────────────────────────────────────────────────────


@then('the user pool is "ACTIVE"')
def pool_is_active_then(lws_session):
    client = _cognito(lws_session)
    resp = client.list_user_pools(MaxResults=10)
    actual_pools = [p["Name"] for p in resp.get("UserPools", [])]
    expected_pool = TEST_POOL_NAME
    assert any(expected_pool == name for name in actual_pools), (
        f"Expected pool '{expected_pool}' to exist but not found in: {actual_pools}"
    )


@then('the user pool is "DELETED"')
def pool_is_deleted_then(lws_session):
    client = _cognito(lws_session)
    resp = client.list_user_pools(MaxResults=10)
    actual_pools = [p["Name"] for p in resp.get("UserPools", [])]
    assert TEST_POOL_NAME not in actual_pools, (
        f"Expected pool '{TEST_POOL_NAME}' to be deleted but found in: {actual_pools}"
    )


@then("the user pool is deleted")
def pool_is_deleted_simple_then(lws_session):
    client = _cognito(lws_session)
    resp = client.list_user_pools(MaxResults=10)
    actual_pools = [p["Name"] for p in resp.get("UserPools", [])]
    assert TEST_POOL_NAME not in actual_pools, (
        f"Expected pool '{TEST_POOL_NAME}' to be deleted but found in: {actual_pools}"
    )


@then('the user is "FORCE_CHANGE_PASSWORD"')
def user_is_force_change_password_then(lws_session, world):
    pool_id = world.get("pool_id", "")
    username = world.get("username", TEST_USERNAME)
    resp = _cognito(lws_session).admin_get_user(UserPoolId=pool_id, Username=username)
    actual_status = resp.get("UserStatus", "")
    expected_status = "FORCE_CHANGE_PASSWORD"
    assert actual_status == expected_status, (
        f"Expected user status '{expected_status}' but got: '{actual_status}'"
    )


@then("the user is deleted")
def user_is_deleted_then(world):
    assert world["error"] is None, (
        f"Expected user deletion to succeed but got: {world['error']}"
    )
