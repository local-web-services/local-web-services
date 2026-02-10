"""``lws cognito-idp`` sub-commands."""

from __future__ import annotations

import asyncio

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
    except Exception as exc:
        exit_with_error(str(exc))
    client_id = resource.get("user_pool_id", "local-client-id")
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
    except Exception as exc:
        exit_with_error(str(exc))
    client_id = resource.get("user_pool_id", "local-client-id")
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
    except Exception as exc:
        exit_with_error(str(exc))
    client_id = resource.get("user_pool_id", "local-client-id")
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
