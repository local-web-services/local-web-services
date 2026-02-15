"""``lws secretsmanager`` sub-commands."""

from __future__ import annotations

import asyncio
import json

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


@app.command("update-secret")
def update_secret(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    secret_string: str = typer.Option(None, "--secret-string", help="New secret string value"),
    description: str = typer.Option(None, "--description", help="New description"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a secret."""
    asyncio.run(_update_secret(secret_id, secret_string, description, port))


async def _update_secret(
    secret_id: str, secret_string: str | None, description: str | None, port: int
) -> None:
    client = _client(port)
    try:
        body: dict = {"SecretId": secret_id}
        if secret_string is not None:
            body["SecretString"] = secret_string
        if description is not None:
            body["Description"] = description
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.UpdateSecret",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("restore-secret")
def restore_secret(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Restore a deleted secret."""
    asyncio.run(_restore_secret(secret_id, port))


async def _restore_secret(secret_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.RestoreSecret",
            {"SecretId": secret_id},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("tag-resource")
def tag_resource(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    tags: str = typer.Option(..., "--tags", help='JSON array of {"Key":"k","Value":"v"}'),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Tag a secret."""
    asyncio.run(_tag_resource(secret_id, tags, port))


async def _tag_resource(secret_id: str, tags: str, port: int) -> None:
    client = _client(port)
    try:
        parsed_tags = json.loads(tags)
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.TagResource",
            {"SecretId": secret_id, "Tags": parsed_tags},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("untag-resource")
def untag_resource(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    tag_keys: str = typer.Option(..., "--tag-keys", help="JSON array of tag keys"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Untag a secret."""
    asyncio.run(_untag_resource(secret_id, tag_keys, port))


async def _untag_resource(secret_id: str, tag_keys: str, port: int) -> None:
    client = _client(port)
    try:
        parsed_keys = json.loads(tag_keys)
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.UntagResource",
            {"SecretId": secret_id, "TagKeys": parsed_keys},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-secret-version-ids")
def list_secret_version_ids(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List version IDs for a secret."""
    asyncio.run(_list_secret_version_ids(secret_id, port))


async def _list_secret_version_ids(secret_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListSecretVersionIds",
            {"SecretId": secret_id},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("get-resource-policy")
def get_resource_policy(
    secret_id: str = typer.Option(..., "--secret-id", help="Secret name or ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get the resource policy for a secret."""
    asyncio.run(_get_resource_policy(secret_id, port))


async def _get_resource_policy(secret_id: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.GetResourcePolicy",
            {"SecretId": secret_id},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
