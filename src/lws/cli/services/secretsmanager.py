"""``lws secretsmanager`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="Secrets Manager commands")

_SERVICE = "secretsmanager"
_TARGET_PREFIX = "secretsmanager"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-secret")
def create_secret(
    name: str = typer.Option(..., "--name", help="Secret name"),
    secret_string: str = typer.Option(None, "--secret-string", help="Secret string value"),
    description: str = typer.Option("", "--description", help="Secret description"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a secret."""
    asyncio.run(_create_secret(name, secret_string, description, port))


async def _create_secret(name: str, secret_string: str | None, description: str, port: int) -> None:
    client = _client(port)
    try:
        body: dict = {"Name": name}
        if secret_string is not None:
            body["SecretString"] = secret_string
        if description:
            body["Description"] = description
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateSecret",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("get-secret-value")
def get_secret_value(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    version_id: str = typer.Option(None, "--version-id", help="Version ID"),
    version_stage: str = typer.Option("AWSCURRENT", "--version-stage", help="Version stage"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a secret value."""
    asyncio.run(_get_secret_value(secret_id, version_id, version_stage, port))


async def _get_secret_value(
    secret_id: str, version_id: str | None, version_stage: str, port: int
) -> None:
    client = _client(port)
    try:
        body: dict = {"SecretId": secret_id, "VersionStage": version_stage}
        if version_id:
            body["VersionId"] = version_id
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.GetSecretValue",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("put-secret-value")
def put_secret_value(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    secret_string: str = typer.Option(..., "--secret-string", help="New secret string value"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Put a new secret value."""
    asyncio.run(_put_secret_value(secret_id, secret_string, port))


async def _put_secret_value(secret_id: str, secret_string: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.PutSecretValue",
            {"SecretId": secret_id, "SecretString": secret_string},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-secret")
def delete_secret(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    force: bool = typer.Option(False, "--force-delete-without-recovery", help="Force delete"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a secret."""
    asyncio.run(_delete_secret(secret_id, force, port))


async def _delete_secret(secret_id: str, force: bool, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteSecret",
            {"SecretId": secret_id, "ForceDeleteWithoutRecovery": force},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-secret")
def describe_secret(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe a secret."""
    asyncio.run(_describe_secret(secret_id, port))


async def _describe_secret(secret_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeSecret",
            {"SecretId": secret_id},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-secrets")
def list_secrets(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all secrets."""
    asyncio.run(_list_secrets(port))


async def _list_secrets(port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListSecrets",
            {},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
