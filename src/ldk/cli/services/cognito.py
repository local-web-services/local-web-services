"""``lws cognito-idp`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from ldk.cli.services.client import LwsClient, exit_with_error, output_json

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


async def _sign_up(
    user_pool_name: str, username: str, password: str, port: int
) -> None:
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


async def _initiate_auth(
    user_pool_name: str, username: str, password: str, port: int
) -> None:
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
