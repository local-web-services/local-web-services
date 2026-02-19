"""Shared fixtures for cognito_idp E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse(
        'a confirmed user "{username}" existed in pool "{pool_name}" with password "{password}"'
    ),
)
def a_confirmed_user_existed(username, pool_name, password, lws_invoke, e2e_port):
    lws_invoke(
        [
            "cognito-idp",
            "sign-up",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--password",
            password,
            "--port",
            str(e2e_port),
        ]
    )
    lws_invoke(
        [
            "cognito-idp",
            "confirm-sign-up",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.parse('a user pool client named "{client_name}" was created in pool "{pool_name}"'),
    target_fixture="created_client",
)
def a_user_pool_client_was_created(client_name, pool_name, created_pool, lws_invoke, e2e_port):
    result_client = lws_invoke(
        [
            "cognito-idp",
            "create-user-pool-client",
            "--user-pool-id",
            created_pool["pool_id"],
            "--client-name",
            client_name,
            "--port",
            str(e2e_port),
        ]
    )
    client_id = result_client["UserPoolClient"]["ClientId"]
    return {"client_id": client_id, "client_name": client_name}


@given(
    parsers.parse('a user pool named "{pool_name}" was created'),
    target_fixture="created_pool",
)
def a_user_pool_was_created(pool_name, lws_invoke, e2e_port):
    output = lws_invoke(
        [
            "cognito-idp",
            "create-user-pool",
            "--pool-name",
            pool_name,
            "--port",
            str(e2e_port),
        ]
    )
    pool_id = output["UserPool"]["Id"]
    return {"pool_name": pool_name, "pool_id": pool_id}


@given(
    parsers.parse(
        'an authenticated user "{username}" existed in pool'
        ' "{pool_name}" with password "{password}"'
    ),
    target_fixture="auth_context",
)
def an_authenticated_user_existed(username, pool_name, password, lws_invoke, e2e_port):
    lws_invoke(
        [
            "cognito-idp",
            "sign-up",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--password",
            password,
            "--port",
            str(e2e_port),
        ]
    )
    lws_invoke(
        [
            "cognito-idp",
            "confirm-sign-up",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--port",
            str(e2e_port),
        ]
    )
    auth_result = lws_invoke(
        [
            "cognito-idp",
            "initiate-auth",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--password",
            password,
            "--port",
            str(e2e_port),
        ]
    )
    access_token = auth_result["AuthenticationResult"]["AccessToken"]
    return {"access_token": access_token}


@when(
    parsers.parse('I admin-create user "{username}" in pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_admin_create_user(username, pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "admin-create-user",
            "--user-pool-id",
            created_pool["pool_id"],
            "--username",
            username,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I admin-delete user "{username}" from pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_admin_delete_user(username, pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "admin-delete-user",
            "--user-pool-id",
            created_pool["pool_id"],
            "--username",
            username,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I admin-get user "{username}" from pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_admin_get_user(username, pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "admin-get-user",
            "--user-pool-id",
            created_pool["pool_id"],
            "--username",
            username,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I change password from "{old_password}" to "{new_password}" using the access token'
    ),
    target_fixture="command_result",
)
def i_change_password(old_password, new_password, auth_context, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "change-password",
            "--access-token",
            auth_context["access_token"],
            "--previous-password",
            old_password,
            "--proposed-password",
            new_password,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I confirm forgot-password for user "{username}" in pool "{pool_name}"'
        ' with code "{code}" and password "{new_password}"'
    ),
    target_fixture="command_result",
)
def i_confirm_forgot_password(username, pool_name, code, new_password, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "confirm-forgot-password",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--confirmation-code",
            code,
            "--password",
            new_password,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I confirm sign-up for user "{username}" in pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_confirm_sign_up(username, pool_name, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "confirm-sign-up",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a user pool named "{pool_name}"'),
    target_fixture="command_result",
)
def i_create_a_user_pool(pool_name, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "create-user-pool",
            "--pool-name",
            pool_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a user pool client named "{client_name}" in pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_create_user_pool_client(client_name, pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "create-user-pool-client",
            "--user-pool-id",
            created_pool["pool_id"],
            "--client-name",
            client_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete user pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_delete_user_pool(pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "delete-user-pool",
            "--user-pool-id",
            created_pool["pool_id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete the user pool client from pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_delete_user_pool_client(pool_name, created_pool, created_client, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "delete-user-pool-client",
            "--user-pool-id",
            created_pool["pool_id"],
            "--client-id",
            created_client["client_id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe user pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_describe_user_pool(pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "describe-user-pool",
            "--user-pool-id",
            created_pool["pool_id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe the user pool client in pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_describe_user_pool_client(pool_name, created_pool, created_client, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "describe-user-pool-client",
            "--user-pool-id",
            created_pool["pool_id"],
            "--client-id",
            created_client["client_id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I global-sign-out using the access token",
    target_fixture="command_result",
)
def i_global_sign_out(auth_context, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "global-sign-out",
            "--access-token",
            auth_context["access_token"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I initiate auth for user "{username}" in pool "{pool_name}" with password "{password}"'
    ),
    target_fixture="command_result",
)
def i_initiate_auth(username, pool_name, password, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "initiate-auth",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--password",
            password,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I initiate forgot-password for user "{username}" in pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_initiate_forgot_password(username, pool_name, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "forgot-password",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list user pool clients in pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_list_user_pool_clients(pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "list-user-pool-clients",
            "--user-pool-id",
            created_pool["pool_id"],
            "--port",
            str(e2e_port),
        ],
    )


@when("I list user pools", target_fixture="command_result")
def i_list_user_pools(e2e_port):
    return runner.invoke(
        app,
        ["cognito-idp", "list-user-pools", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I list users in pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_list_users(pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "list-users",
            "--user-pool-id",
            created_pool["pool_id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I sign up user "{username}" in pool "{pool_name}" with password "{password}"'),
    target_fixture="command_result",
)
def i_sign_up_user(username, pool_name, password, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "sign-up",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--password",
            password,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update user pool "{pool_name}"'),
    target_fixture="command_result",
)
def i_update_user_pool(pool_name, created_pool, e2e_port):
    return runner.invoke(
        app,
        [
            "cognito-idp",
            "update-user-pool",
            "--user-pool-id",
            created_pool["pool_id"],
            "--port",
            str(e2e_port),
        ],
    )


@then("the output will contain an AuthenticationResult")
def the_output_will_contain_auth_result(command_result, parse_output):
    data = parse_output(command_result.output)
    assert "AuthenticationResult" in data


@then("the output will contain CodeDeliveryDetails")
def the_output_will_contain_code_delivery(command_result, parse_output):
    data = parse_output(command_result.output)
    assert "CodeDeliveryDetails" in data


@then("the output will contain a CodeMismatchException error")
def the_output_will_contain_code_mismatch(command_result, parse_output):
    data = parse_output(command_result.output)
    expected_error = "CodeMismatchException"
    actual_error = data["__type"]
    assert actual_error == expected_error


@then(
    parsers.parse('the output will contain a user pool named "{expected_name}"'),
)
def the_output_will_contain_pool_name(expected_name, command_result, parse_output):
    data = parse_output(command_result.output)
    actual_name = data["UserPool"]["Name"]
    assert actual_name == expected_name


@then("the output will contain a UserConfirmed field")
def the_output_will_contain_user_confirmed(command_result, parse_output):
    data = parse_output(command_result.output)
    assert data.get("UserConfirmed") is not None


@then(
    parsers.parse('the user pool list will include "{expected_name}"'),
)
def the_user_pool_list_will_include(expected_name, command_result, parse_output):
    data = parse_output(command_result.output)
    actual_names = [p["Name"] for p in data["UserPools"]]
    assert expected_name in actual_names


@then(
    parsers.parse('the user pool list will not include "{expected_name}"'),
)
def the_user_pool_list_will_not_include(expected_name, assert_invoke, e2e_port):
    verify = assert_invoke(["cognito-idp", "list-user-pools", "--port", str(e2e_port)])
    actual_names = [p["Name"] for p in verify.get("UserPools", [])]
    assert expected_name not in actual_names


@then(
    parsers.parse('user pool "{pool_name}" will exist'),
)
def user_pool_will_exist(pool_name, command_result, parse_output, assert_invoke, e2e_port):
    data = parse_output(command_result.output)
    pool_id = data["UserPool"]["Id"]
    verify = assert_invoke(
        [
            "cognito-idp",
            "describe-user-pool",
            "--user-pool-id",
            pool_id,
            "--port",
            str(e2e_port),
        ]
    )
    actual_name = verify["UserPool"]["Name"]
    assert actual_name == pool_name


@given(
    parsers.parse('user "{username}" was admin-created in pool "{pool_name}"'),
)
def user_was_admin_created(username, pool_name, created_pool, lws_invoke, e2e_port):
    lws_invoke(
        [
            "cognito-idp",
            "admin-create-user",
            "--user-pool-id",
            created_pool["pool_id"],
            "--username",
            username,
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.parse(
        'user "{username}" was signed up in pool "{pool_name}" with password "{password}"'
    ),
)
def user_was_signed_up(username, pool_name, password, lws_invoke, e2e_port):
    lws_invoke(
        [
            "cognito-idp",
            "sign-up",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--password",
            password,
            "--port",
            str(e2e_port),
        ]
    )


@then(
    parsers.parse(
        'user "{username}" will authenticate in pool "{pool_name}" with password "{password}"'
    ),
)
def user_will_authenticate(username, pool_name, password, assert_invoke, e2e_port):
    new_auth = assert_invoke(
        [
            "cognito-idp",
            "initiate-auth",
            "--user-pool-name",
            pool_name,
            "--username",
            username,
            "--password",
            password,
            "--port",
            str(e2e_port),
        ]
    )
    assert "AuthenticationResult" in new_auth


@then(
    parsers.parse("the user pool client will not appear in list-user-pool-clients"),
)
def the_user_pool_client_will_not_appear(created_pool, created_client, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "cognito-idp",
            "list-user-pool-clients",
            "--user-pool-id",
            created_pool["pool_id"],
            "--port",
            str(e2e_port),
        ]
    )
    actual_ids = [c["ClientId"] for c in verify.get("UserPoolClients", [])]
    expected_id = created_client["client_id"]
    assert expected_id not in actual_ids


@then(
    parsers.parse('user "{username}" will appear in list-users'),
)
def user_will_appear_in_list(username, created_pool, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "cognito-idp",
            "list-users",
            "--user-pool-id",
            created_pool["pool_id"],
            "--port",
            str(e2e_port),
        ]
    )
    actual_usernames = [u["Username"] for u in verify.get("Users", [])]
    assert username in actual_usernames


@then(
    parsers.parse('user "{username}" will not appear in list-users'),
)
def user_will_not_appear_in_list(username, created_pool, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "cognito-idp",
            "list-users",
            "--user-pool-id",
            created_pool["pool_id"],
            "--port",
            str(e2e_port),
        ]
    )
    actual_usernames = [u["Username"] for u in verify.get("Users", [])]
    assert username not in actual_usernames


@then(
    parsers.parse('user "{username}" will have status "{expected_status}"'),
)
def user_will_have_status(username, expected_status, created_pool, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "cognito-idp",
            "admin-get-user",
            "--user-pool-id",
            created_pool["pool_id"],
            "--username",
            username,
            "--port",
            str(e2e_port),
        ]
    )
    actual_status = verify["UserStatus"]
    assert actual_status == expected_status
