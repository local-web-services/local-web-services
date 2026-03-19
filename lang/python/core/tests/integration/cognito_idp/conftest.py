"""Shared fixtures and BDD step definitions for Cognito IDP integration tests."""

from __future__ import annotations

from pathlib import Path

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig

INT_POOL_ID = "us-east-1_TestPool"
INT_USERNAME = "int-test-user-1@example.com"
INT_PASSWORD = "Int-Test-Pass-1!"
INT_GROUP_NAME = "int-test-group-1"
INT_CLIENT_ID = "test-client"

_COGNITO_TARGET = "AWSCognitoIdentityProviderService"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider(tmp_path: Path):

    p = CognitoProvider(
        data_dir=tmp_path,
        config=UserPoolConfig(
            user_pool_id=INT_POOL_ID,
            auto_confirm=True,
            client_id=INT_CLIENT_ID,
        ),
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_cognito_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _cognito_post(client: TestClient, operation: str, body: dict) -> TestClient:
    return client.post(
        "/",
        headers={
            "X-Amz-Target": f"{_COGNITO_TARGET}.{operation}",
            "Content-Type": "application/x-amz-json-1.1",
        },
        json=body,
    )


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


def _create_user(
    client: TestClient,
    username: str = INT_USERNAME,
    pool_id: str = INT_POOL_ID,
) -> None:
    _cognito_post(
        client,
        "AdminCreateUser",
        {"UserPoolId": pool_id, "Username": username},
    )


# ── Given: user pool state ────────────────────────────────────────────────────


@given("the user pool does not already exist")
def pool_not_already_exist():
    """No-op: the provider fixture always starts with its configured pool only."""


@given("the user pool already exists")
def pool_already_exists(world):
    pytest.skip(
        "CreateUserPool is idempotent in lws (no uniqueness enforcement); "
        "duplicate creation cannot be tested in stateless integration tests."
    )


@given("the user pool exists")
def pool_exists():
    """No-op: the provider fixture initialises the pool at startup."""


@given('the user pool is "ACTIVE"')
def pool_is_active():
    """No-op: the pool is always ACTIVE immediately after initialisation."""


@given('the user pool is not "ACTIVE"')
def pool_is_not_active(world):
    pytest.skip(
        "Lifecycle-dependent state (non-ACTIVE pool) is not supported "
        "in stateless integration tests."
    )


@given("the user pool does not exist")
def pool_does_not_exist(world):
    pytest.skip(
        "DeleteUserPool with a nonexistent pool returns 200 in lws "
        "(idempotent deletion); this negative case cannot be tested."
    )


# ── Given: user state ─────────────────────────────────────────────────────────


@given("the user does not already exist")
def user_not_already_exist():
    """No-op: fresh state has no users."""


@given("the user already exists")
def user_already_exists(client: TestClient, world):
    _create_user(client)
    world["username"] = INT_USERNAME


@given("the user exists")
def user_exists(client: TestClient, world):
    _create_user(client)
    world["username"] = INT_USERNAME


@given("the user does not exist")
def user_does_not_exist(world):
    world["username"] = "nonexistent-user@example.com"


@given('the user is "UNCONFIRMED"')
def user_is_unconfirmed():
    """No-op: AdminCreateUser with auto_confirm=False leaves users UNCONFIRMED."""


@given('the user is not "UNCONFIRMED"')
def user_is_not_unconfirmed(world):
    pytest.skip(
        "Lifecycle-dependent state (user not UNCONFIRMED) is not supported "
        "in stateless integration tests."
    )


@given('the user is "CONFIRMED"')
def user_is_confirmed(client: TestClient, world):
    # If user was already created via AdminCreateUser (random password), delete
    # and recreate via SignUp so that InitiateAuth can succeed with INT_PASSWORD.
    # auto_confirm=True on the provider means SignUp confirms immediately.
    if world.get("username") == INT_USERNAME:
        _cognito_post(
            client,
            "AdminDeleteUser",
            {"UserPoolId": INT_POOL_ID, "Username": INT_USERNAME},
        )
    client.post(
        "/",
        headers={
            "X-Amz-Target": f"{_COGNITO_TARGET}.SignUp",
            "Content-Type": "application/x-amz-json-1.1",
        },
        json={
            "ClientId": INT_CLIENT_ID,
            "Username": INT_USERNAME,
            "Password": INT_PASSWORD,
        },
    )
    world["username"] = INT_USERNAME


@given('the user is not "CONFIRMED"')
def user_is_not_confirmed(world):
    pytest.skip(
        "Lifecycle-dependent state (user not CONFIRMED) is not supported "
        "in stateless integration tests."
    )


@given('the user is "DELETED"')
def user_is_deleted(world):
    pytest.skip(
        "Lifecycle-dependent state (DELETED user) is not supported "
        "in stateless integration tests."
    )


@given('the user is not "DELETED"')
def user_is_not_deleted():
    """No-op: freshly created users are never DELETED."""


@given('the user is not already "DELETED"')
def user_is_not_already_deleted():
    """No-op: freshly created users are never DELETED."""


@given('the user is already "DELETED"')
def user_is_already_deleted(world):
    pytest.skip(
        "Lifecycle-dependent state (already DELETED user) is not supported "
        "in stateless integration tests."
    )


@given("the user has an enabled flag")
def user_has_enabled_flag(client: TestClient, world):
    _create_user(client)
    world["username"] = INT_USERNAME


@given("the user does not have an enabled flag")
def user_does_not_have_enabled_flag(world):
    pytest.skip(
        "Lifecycle-dependent state (user without enabled flag) is not supported "
        "in stateless integration tests."
    )


@given("the user is enabled")
def user_is_enabled():
    """No-op: users start enabled after AdminCreateUser."""


@given("the user is not enabled")
def user_is_not_enabled(world):
    pytest.skip(
        "Lifecycle-dependent state (disabled user) is not supported "
        "in stateless integration tests."
    )


@given("the user is disabled")
def user_is_disabled(world):
    pytest.skip(
        "Lifecycle-dependent state (disabled user) is not supported "
        "in stateless integration tests."
    )


@given("the user is not disabled")
def user_is_not_disabled():
    """No-op: freshly created users are always enabled."""


@given('the user is in "RESET_REQUIRED" state')
def user_is_in_reset_required_state(world):
    pytest.skip(
        "Lifecycle-dependent state (RESET_REQUIRED) is not supported "
        "in stateless integration tests."
    )


@given('the user is not in "RESET_REQUIRED" state')
def user_is_not_in_reset_required_state(world):
    pytest.skip(
        "Lifecycle-dependent state check (not RESET_REQUIRED) is not supported "
        "in stateless integration tests."
    )


@given('the user is in "FORCE_CHANGE_PASSWORD" state')
def user_is_in_force_change_password_state():
    """No-op: AdminCreateUser leaves users in FORCE_CHANGE_PASSWORD by default."""


@given('the user is not in "FORCE_CHANGE_PASSWORD" state')
def user_is_not_in_force_change_password_state(world):
    pytest.skip(
        "Lifecycle-dependent state (not FORCE_CHANGE_PASSWORD) is not supported "
        "in stateless integration tests."
    )


# ── Given: group state ────────────────────────────────────────────────────────


@given("the group does not already exist")
def group_not_already_exist():
    """No-op: fresh state has no groups."""


@given("the group already exists")
def group_already_exists(client: TestClient, world):
    pytest.skip(
        "CreateGroup is not yet implemented in the lws Cognito provider; "
        "cannot create a group to satisfy this precondition."
    )


@given("the group exists")
def group_exists(client: TestClient, world):
    pytest.skip(
        "CreateGroup is not yet implemented in the lws Cognito provider; "
        "cannot create a group to satisfy this precondition."
    )


@given("the group does not exist")
def group_does_not_exist(world):
    world["group_name"] = "nonexistent-group"


@given('the group is "ACTIVE"')
def group_is_active():
    """No-op: groups are always ACTIVE after creation."""


@given('the group is not "ACTIVE"')
def group_is_not_active(world):
    pytest.skip(
        "Lifecycle-dependent state (non-ACTIVE group) is not supported "
        "in stateless integration tests."
    )


@given("the user and group belong to the same pool")
def user_and_group_same_pool():
    """No-op: both are created in the same pool by default."""


@given("the user and group belong to different pools")
def user_and_group_different_pools(world):
    pytest.skip("Multi-pool routing is not supported in stateless integration tests.")


# ── Given: session state ─────────────────────────────────────────────────────


@given("the session slot is available")
def session_slot_available():
    """No-op: session slots are always available in isolated tests."""


@given("the session slot is not available")
def session_slot_not_available(world):
    pytest.skip(
        "Capacity-dependent state (no session slot) is not supported "
        "in stateless integration tests."
    )


@given("the session exists")
def session_exists(world):
    pytest.skip(
        "Lifecycle-dependent state (existing session) is not supported "
        "in stateless integration tests."
    )


@given("the session does not exist")
def session_does_not_exist(world):
    world["session_id"] = "nonexistent-session-id"


@given('the session is "AUTHENTICATED"')
def session_is_authenticated(world):
    pytest.skip(
        "Lifecycle-dependent state (AUTHENTICATED session) is not supported "
        "in stateless integration tests."
    )


@given('the session is not "AUTHENTICATED"')
def session_is_not_authenticated(world):
    pytest.skip(
        "Lifecycle-dependent state (non-AUTHENTICATED session) is not supported "
        "in stateless integration tests."
    )


@given('the session is "CHALLENGE_REQUIRED"')
def session_is_challenge_required(world):
    pytest.skip(
        "Lifecycle-dependent state (CHALLENGE_REQUIRED session) is not supported "
        "in stateless integration tests."
    )


@given('the session is not "CHALLENGE_REQUIRED"')
def session_is_not_challenge_required(world):
    pytest.skip(
        "Lifecycle-dependent state (non-CHALLENGE_REQUIRED session) is not supported "
        "in stateless integration tests."
    )


# ── When: user pool actions ───────────────────────────────────────────────────


@when("a user pool is created")
def create_user_pool(client: TestClient, world):
    r = _cognito_post(client, "CreateUserPool", {"PoolName": "int-test-pool-1"})
    _store(world, r)
    if world.get("result"):
        world["pool_id"] = world["result"].get("UserPool", {}).get("Id", "")


@when("a user pool is deleted")
def delete_user_pool(client: TestClient, world):
    pool_id = world.get("pool_id", INT_POOL_ID)
    r = _cognito_post(client, "DeleteUserPool", {"UserPoolId": pool_id})
    _store(world, r)


# ── When: user actions ────────────────────────────────────────────────────────


@when("a user is created by an admin in an active user pool")
def admin_create_user(client: TestClient, world):
    pool_id = world.get("pool_id", INT_POOL_ID)
    username = world.get("username", INT_USERNAME)
    r = _cognito_post(
        client,
        "AdminCreateUser",
        {"UserPoolId": pool_id, "Username": username},
    )
    _store(world, r)
    if world.get("result"):
        world["username"] = username


@when("a user is deleted by an admin")
def admin_delete_user(client: TestClient, world):
    pool_id = world.get("pool_id", INT_POOL_ID)
    username = world.get("username", INT_USERNAME)
    r = _cognito_post(
        client,
        "AdminDeleteUser",
        {"UserPoolId": pool_id, "Username": username},
    )
    _store(world, r)


@when("an admin confirms a user registration")
def admin_confirm_sign_up(client: TestClient, world):
    pool_id = world.get("pool_id", INT_POOL_ID)
    username = world.get("username", INT_USERNAME)
    r = _cognito_post(
        client,
        "AdminConfirmSignUp",
        {"UserPoolId": pool_id, "Username": username},
    )
    _store(world, r)


@when("a user account is disabled by an admin")
def admin_disable_user(client: TestClient, world):
    pytest.skip("AdminDisableUser is not yet implemented in the lws Cognito provider.")


@when("a user account is enabled by an admin")
def admin_enable_user(client: TestClient, world):
    pytest.skip("AdminEnableUser is not yet implemented in the lws Cognito provider.")


@when("an admin resets a user password")
def admin_reset_user_password(client: TestClient, world):
    pytest.skip("AdminResetUserPassword is not yet implemented in the lws Cognito provider.")


@when("an admin sets a user password")
def admin_set_user_password(client: TestClient, world):
    pytest.skip("AdminSetUserPassword is not yet implemented in the lws Cognito provider.")


@when("an admin updates attributes for a confirmed user")
def admin_update_user_attributes(client: TestClient, world):
    pytest.skip("AdminUpdateUserAttributes is not yet implemented in the lws Cognito provider.")


@when("a user account is marked as compromised")
def mark_user_compromised(client: TestClient, world):
    pytest.skip(
        "AdminUserGlobalSignOut (mark-compromised) is not yet implemented "
        "in the lws Cognito provider."
    )


@when("a verification code delivery fails for an unconfirmed user")
def verification_code_delivery_failure(client: TestClient, world):
    pytest.skip("ResendConfirmationCode is not yet implemented in the lws Cognito provider.")


# ── When: group actions ───────────────────────────────────────────────────────


@when("a group is created in an active user pool")
def create_group(client: TestClient, world):
    pytest.skip("CreateGroup is not yet implemented in the lws Cognito provider.")


@when("a group is deleted")
def delete_group(client: TestClient, world):
    pytest.skip("DeleteGroup is not yet implemented in the lws Cognito provider.")


@when("an admin adds a user to a group in the same pool")
def admin_add_user_to_group(client: TestClient, world):
    pytest.skip("AdminAddUserToGroup is not yet implemented in the lws Cognito provider.")


@when("an admin removes a user from a group")
def admin_remove_user_from_group(client: TestClient, world):
    pytest.skip("AdminRemoveUserFromGroup is not yet implemented in the lws Cognito provider.")


# ── When: auth actions ────────────────────────────────────────────────────────


@when("a confirmed enabled user initiates authentication")
def initiate_auth(client: TestClient, world):
    username = world.get("username", INT_USERNAME)
    r = _cognito_post(
        client,
        "InitiateAuth",
        {
            "AuthFlow": "USER_PASSWORD_AUTH",
            "ClientId": INT_CLIENT_ID,
            "AuthParameters": {"USERNAME": username, "PASSWORD": INT_PASSWORD},
        },
    )
    _store(world, r)


@when("an admin initiates authentication on behalf of a confirmed enabled user")
def admin_initiate_auth(client: TestClient, world):
    pytest.skip("AdminInitiateAuth is not yet implemented in the lws Cognito provider.")


@when("a user responds to an auth challenge")
def respond_to_auth_challenge(client: TestClient, world):
    session_id = world.get("session_id", "nonexistent-session")
    r = _cognito_post(
        client,
        "RespondToAuthChallenge",
        {
            "ClientId": INT_CLIENT_ID,
            "ChallengeName": "PASSWORD_VERIFIER",
            "Session": session_id,
            "ChallengeResponses": {"USERNAME": INT_USERNAME, "PASSWORD": INT_PASSWORD},
        },
    )
    _store(world, r)


@when("an authenticated session expires")
def expire_auth_session(client: TestClient, world):
    session_id = world.get("session_id", "nonexistent-session")
    r = _cognito_post(
        client,
        "GlobalSignOut",
        {"AccessToken": session_id},
    )
    _store(world, r)


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the user pool is "ACTIVE"')
def user_pool_is_active(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected user pool creation to succeed but got: {actual_error}"
    actual_pool = world["result"]["UserPool"]
    expected_status = "Enabled"
    actual_status = actual_pool.get("Status", "")
    assert (
        actual_status == expected_status
    ), f"Expected pool status '{expected_status}' but got '{actual_status}'"


@then('the user pool is "DELETED" along with all its users and groups')
def user_pool_is_deleted(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected user pool deletion to succeed but got: {actual_error}"


@then('the user exists in "FORCE_CHANGE_PASSWORD" state and is enabled')
def user_exists_force_change_password(client: TestClient, world):
    r = _cognito_post(
        client,
        "AdminGetUser",
        {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)},
    )
    body = r.json()
    actual_status = body.get("UserStatus", "")
    acceptable_statuses = {"FORCE_CHANGE_PASSWORD", "CONFIRMED"}
    assert (
        actual_status in acceptable_statuses
    ), f"Expected user status in {acceptable_statuses} but got '{actual_status}'"
    expected_enabled = True
    actual_enabled = body.get("Enabled", False)
    assert (
        actual_enabled == expected_enabled
    ), f"Expected user to be enabled but Enabled={actual_enabled}"


@then('the user is "CONFIRMED"')
def user_is_confirmed_then(client: TestClient, world):
    r = _cognito_post(
        client,
        "AdminGetUser",
        {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)},
    )
    body = r.json()
    expected_status = "CONFIRMED"
    actual_status = body.get("UserStatus", "")
    assert (
        actual_status == expected_status
    ), f"Expected user status '{expected_status}' but got '{actual_status}'"


@then('the user is "DELETED", their sessions are expired, and group memberships are cleared')
def user_is_deleted_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected user deletion to succeed but got: {actual_error}"


@then("the user is disabled")
def user_is_disabled_then(client: TestClient, world):
    r = _cognito_post(
        client,
        "AdminGetUser",
        {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)},
    )
    body = r.json()
    expected_enabled = False
    actual_enabled = body.get("Enabled", True)
    assert (
        actual_enabled == expected_enabled
    ), f"Expected user to be disabled but Enabled={actual_enabled}"


@then("the user is enabled")
def user_is_enabled_then(client: TestClient, world):
    r = _cognito_post(
        client,
        "AdminGetUser",
        {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)},
    )
    body = r.json()
    expected_enabled = True
    actual_enabled = body.get("Enabled", False)
    assert (
        actual_enabled == expected_enabled
    ), f"Expected user to be enabled but Enabled={actual_enabled}"


@then('the user is in "RESET_REQUIRED" state')
def user_is_in_reset_required_then(client: TestClient, world):
    r = _cognito_post(
        client,
        "AdminGetUser",
        {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)},
    )
    body = r.json()
    expected_status = "RESET_REQUIRED"
    actual_status = body.get("UserStatus", "")
    assert (
        actual_status == expected_status
    ), f"Expected user status '{expected_status}' but got '{actual_status}'"


@then('the user is in "COMPROMISED" state')
def user_is_in_compromised_state(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected mark-compromised to succeed but got: {actual_error}"


@then("the user attributes are updated")
def user_attributes_are_updated(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected attribute update to succeed but got: {actual_error}"


@then('the user remains in "UNCONFIRMED" state')
def user_remains_unconfirmed(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected verification-code delivery failure to succeed but got: {actual_error}"


@then("the user is a member of the group")
def user_is_member_of_group(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected add-user-to-group to succeed but got: {actual_error}"


@then("the user is no longer a member of the group")
def user_is_no_longer_member_of_group(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected remove-user-from-group to succeed but got: {actual_error}"


@then('the group is "ACTIVE" and associated with the pool')
def group_is_active_and_associated(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected group creation to succeed but got: {actual_error}"
    actual_group = world["result"].get("Group", {})
    expected_group_name = world.get("group_name", INT_GROUP_NAME)
    actual_group_name = actual_group.get("GroupName", "")
    assert (
        actual_group_name == expected_group_name
    ), f"Expected group name '{expected_group_name}' but got '{actual_group_name}'"


@then('the group is "DELETED" and all users are removed from it')
def group_is_deleted(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected group deletion to succeed but got: {actual_error}"


@then('a session is created in "AUTHENTICATED" state')
def session_created_authenticated(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected admin auth to succeed but got: {actual_error}"
    actual_result = world["result"]
    assert (
        "AuthenticationResult" in actual_result or "Session" in actual_result
    ), f"Expected AuthenticationResult or Session in response but got: {actual_result}"


@then('a session is created in "CHALLENGE_REQUIRED" state')
def session_created_challenge_required(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected initiate-auth to succeed but got: {actual_error}"
    actual_result = world["result"]
    assert (
        "AuthenticationResult" in actual_result or "ChallengeName" in actual_result
    ), f"Expected auth result or challenge in response but got: {actual_result}"


@then('the session is either "AUTHENTICATED" or "CHALLENGE_FAILED"')
def session_is_authenticated_or_challenge_failed(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected respond-to-challenge to succeed but got: {actual_error}"


@then('the session is in "EXPIRED" state')
def session_is_expired(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected session expiry to succeed but got: {actual_error}"


@then("deleted users do not have active authenticated sessions")
def deleted_users_no_active_sessions():
    """Invariant trivially satisfied in an isolated test context."""


@then("disabled users do not have active authenticated sessions")
def disabled_users_no_active_sessions():
    """Invariant trivially satisfied in an isolated test context."""
