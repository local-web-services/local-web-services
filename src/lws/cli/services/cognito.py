"""``lws cognito-idp`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="Cognito Identity Provider commands")

_SERVICE = "cognito-idp"
_TARGET_PREFIX = "AWSCognitoIdentityProviderService"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("sign-up")
def sign_up(
    user_pool_name: str = typer.Option(..., "--user-pool-name", help="User pool name"),
    username: str = typer.Option(..., "--username", help="Username"),
    password: str = typer.Option(..., "--password", help="Password"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Sign up a new user."""
    asyncio.run(_sign_up(user_pool_name, username, password, port))


async def _sign_up(user_pool_name: str, username: str, password: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, user_pool_name)
        client_id = resource.get("user_pool_id", "local-client-id")
    except Exception:
        client_id = "local-client-id"
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.SignUp",
        {
            "ClientId": client_id,
            "Username": username,
            "Password": password,
        },
        content_type="application/x-amz-json-1.1",
    )
    output_json(result)


@app.command("confirm-sign-up")
def confirm_sign_up(
    user_pool_name: str = typer.Option(..., "--user-pool-name", help="User pool name"),
    username: str = typer.Option(..., "--username", help="Username"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Confirm a user sign-up."""
    asyncio.run(_confirm_sign_up(user_pool_name, username, port))


async def _confirm_sign_up(user_pool_name: str, username: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, user_pool_name)
        client_id = resource.get("user_pool_id", "local-client-id")
    except Exception:
        client_id = "local-client-id"
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.ConfirmSignUp",
        {
            "ClientId": client_id,
            "Username": username,
            "ConfirmationCode": "000000",
        },
        content_type="application/x-amz-json-1.1",
    )
    output_json(result)


@app.command("initiate-auth")
def initiate_auth(
    user_pool_name: str = typer.Option(..., "--user-pool-name", help="User pool name"),
    username: str = typer.Option(..., "--username", help="Username"),
    password: str = typer.Option(..., "--password", help="Password"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Authenticate a user."""
    asyncio.run(_initiate_auth(user_pool_name, username, password, port))


async def _initiate_auth(user_pool_name: str, username: str, password: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, user_pool_name)
        client_id = resource.get("user_pool_id", "local-client-id")
    except Exception:
        client_id = "local-client-id"
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.InitiateAuth",
        {
            "ClientId": client_id,
            "AuthFlow": "USER_PASSWORD_AUTH",
            "AuthParameters": {
                "USERNAME": username,
                "PASSWORD": password,
            },
        },
        content_type="application/x-amz-json-1.1",
    )
    output_json(result)


@app.command("create-user-pool")
def create_user_pool(
    pool_name: str = typer.Option(..., "--pool-name", help="User pool name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a user pool."""
    asyncio.run(_create_user_pool(pool_name, port))


async def _create_user_pool(pool_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateUserPool",
            {"PoolName": pool_name},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-user-pool")
def delete_user_pool(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a user pool."""
    asyncio.run(_delete_user_pool(user_pool_id, port))


async def _delete_user_pool(user_pool_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteUserPool",
            {"UserPoolId": user_pool_id},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-user-pools")
def list_user_pools(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List user pools."""
    asyncio.run(_list_user_pools(port))


async def _list_user_pools(port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListUserPools",
            {"MaxResults": 60},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-user-pool")
def describe_user_pool(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe a user pool."""
    asyncio.run(_describe_user_pool(user_pool_id, port))


async def _describe_user_pool(user_pool_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeUserPool",
            {"UserPoolId": user_pool_id},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("forgot-password")
def forgot_password(
    user_pool_name: str = typer.Option(..., "--user-pool-name", help="User pool name"),
    username: str = typer.Option(..., "--username", help="Username"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Initiate a forgot password flow."""
    asyncio.run(_forgot_password(user_pool_name, username, port))


async def _forgot_password(user_pool_name: str, username: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, user_pool_name)
        client_id = resource.get("user_pool_id", "local-client-id")
    except Exception:
        client_id = "local-client-id"
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.ForgotPassword",
        {
            "ClientId": client_id,
            "Username": username,
        },
        content_type="application/x-amz-json-1.1",
    )
    output_json(result)


@app.command("confirm-forgot-password")
def confirm_forgot_password(
    user_pool_name: str = typer.Option(..., "--user-pool-name", help="User pool name"),
    username: str = typer.Option(..., "--username", help="Username"),
    confirmation_code: str = typer.Option(..., "--confirmation-code", help="Confirmation code"),
    password: str = typer.Option(..., "--password", help="New password"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Confirm a forgot password with a confirmation code."""
    asyncio.run(
        _confirm_forgot_password(user_pool_name, username, confirmation_code, password, port)
    )


async def _confirm_forgot_password(
    user_pool_name: str, username: str, confirmation_code: str, password: str, port: int
) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, user_pool_name)
        client_id = resource.get("user_pool_id", "local-client-id")
    except Exception:
        client_id = "local-client-id"
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.ConfirmForgotPassword",
        {
            "ClientId": client_id,
            "Username": username,
            "ConfirmationCode": confirmation_code,
            "Password": password,
        },
        content_type="application/x-amz-json-1.1",
    )
    output_json(result)


@app.command("change-password")
def change_password(
    access_token: str = typer.Option(..., "--access-token", help="Access token"),
    previous_password: str = typer.Option(..., "--previous-password", help="Previous password"),
    proposed_password: str = typer.Option(..., "--proposed-password", help="Proposed new password"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Change a user's password using an access token."""
    asyncio.run(_change_password(access_token, previous_password, proposed_password, port))


async def _change_password(
    access_token: str, previous_password: str, proposed_password: str, port: int
) -> None:
    client = _client(port)
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.ChangePassword",
        {
            "AccessToken": access_token,
            "PreviousPassword": previous_password,
            "ProposedPassword": proposed_password,
        },
        content_type="application/x-amz-json-1.1",
    )
    output_json(result)


@app.command("global-sign-out")
def global_sign_out(
    access_token: str = typer.Option(..., "--access-token", help="Access token"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Sign out a user from all devices."""
    asyncio.run(_global_sign_out(access_token, port))


async def _global_sign_out(access_token: str, port: int) -> None:
    client = _client(port)
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.GlobalSignOut",
        {"AccessToken": access_token},
        content_type="application/x-amz-json-1.1",
    )
    output_json(result)


@app.command("create-user-pool-client")
def create_user_pool_client(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    client_name: str = typer.Option(..., "--client-name", help="Client name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a user pool client."""
    asyncio.run(_create_user_pool_client(user_pool_id, client_name, port))


async def _create_user_pool_client(user_pool_id: str, client_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateUserPoolClient",
            {"UserPoolId": user_pool_id, "ClientName": client_name},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-user-pool-client")
def delete_user_pool_client(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    client_id: str = typer.Option(..., "--client-id", help="Client ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a user pool client."""
    asyncio.run(_delete_user_pool_client(user_pool_id, client_id, port))


async def _delete_user_pool_client(user_pool_id: str, client_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteUserPoolClient",
            {"UserPoolId": user_pool_id, "ClientId": client_id},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-user-pool-client")
def describe_user_pool_client(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    client_id: str = typer.Option(..., "--client-id", help="Client ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe a user pool client."""
    asyncio.run(_describe_user_pool_client(user_pool_id, client_id, port))


async def _describe_user_pool_client(user_pool_id: str, client_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeUserPoolClient",
            {"UserPoolId": user_pool_id, "ClientId": client_id},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-user-pool-clients")
def list_user_pool_clients(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List user pool clients."""
    asyncio.run(_list_user_pool_clients(user_pool_id, port))


async def _list_user_pool_clients(user_pool_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListUserPoolClients",
            {"UserPoolId": user_pool_id, "MaxResults": 60},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("admin-create-user")
def admin_create_user(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    username: str = typer.Option(..., "--username", help="Username"),
    temporary_password: str = typer.Option(None, "--temporary-password", help="Temporary password"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Admin create a user."""
    asyncio.run(_admin_create_user(user_pool_id, username, temporary_password, port))


async def _admin_create_user(
    user_pool_id: str, username: str, temporary_password: str | None, port: int
) -> None:
    client = _client(port)
    body: dict = {"UserPoolId": user_pool_id, "Username": username}
    if temporary_password is not None:
        body["TemporaryPassword"] = temporary_password
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.AdminCreateUser",
            body,
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("admin-delete-user")
def admin_delete_user(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    username: str = typer.Option(..., "--username", help="Username"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Admin delete a user."""
    asyncio.run(_admin_delete_user(user_pool_id, username, port))


async def _admin_delete_user(user_pool_id: str, username: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.AdminDeleteUser",
            {"UserPoolId": user_pool_id, "Username": username},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("admin-get-user")
def admin_get_user(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    username: str = typer.Option(..., "--username", help="Username"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Admin get a user."""
    asyncio.run(_admin_get_user(user_pool_id, username, port))


async def _admin_get_user(user_pool_id: str, username: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.AdminGetUser",
            {"UserPoolId": user_pool_id, "Username": username},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("update-user-pool")
def update_user_pool(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    auto_verified_attributes: str = typer.Option(
        None, "--auto-verified-attributes", help="Auto-verified attributes (JSON array)"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a user pool."""
    asyncio.run(_update_user_pool(user_pool_id, auto_verified_attributes, port))


async def _update_user_pool(
    user_pool_id: str, auto_verified_attributes: str | None, port: int
) -> None:
    client = _client(port)
    body: dict = {"UserPoolId": user_pool_id}
    if auto_verified_attributes is not None:
        body["AutoVerifiedAttributes"] = json.loads(auto_verified_attributes)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.UpdateUserPool",
            body,
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-users")
def list_users(
    user_pool_id: str = typer.Option(..., "--user-pool-id", help="User pool ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List users in a user pool."""
    asyncio.run(_list_users(user_pool_id, port))


async def _list_users(user_pool_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListUsers",
            {"UserPoolId": user_pool_id, "Limit": 60},
            content_type="application/x-amz-json-1.1",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
