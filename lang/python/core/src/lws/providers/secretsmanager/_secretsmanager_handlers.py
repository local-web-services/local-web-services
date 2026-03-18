"""Secrets Manager action handler functions."""

from __future__ import annotations

import json
import time
from typing import Any

from fastapi import Response

from lws.providers.secretsmanager._secretsmanager_state import (
    _find_secret,
    _format_secret_description,
    _resolve_version,
    _rotate_secret_version,
    _Secret,
    _SecretsState,
)


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON response."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response in Secrets Manager format."""
    error_body = {"__type": code, "Message": message}
    return _json_response(error_body, status_code=status_code)


async def _handle_create_secret(state: _SecretsState, body: dict) -> Response:
    name = body.get("Name", "")
    description = body.get("Description", "")
    secret_string = body.get("SecretString")
    secret_binary = body.get("SecretBinary")
    tags_list = body.get("Tags", [])
    tags = {t["Key"]: t["Value"] for t in tags_list} if tags_list else {}

    if name in state.secrets:
        existing = state.secrets[name]
        if existing.deleted_date is not None:
            # Restore soft-deleted secret
            existing.deleted_date = None
            existing.description = description
            existing.tags = tags
        else:
            return _error_response(
                "ResourceExistsException",
                f"The secret {name} already exists.",
            )

    secret = _Secret(name=name, description=description, tags=tags)
    state.secrets[name] = secret

    version_id: str | None = None
    if secret_string is not None or secret_binary is not None:
        version_id = _rotate_secret_version(secret, secret_string, secret_binary)

    result: dict[str, Any] = {"ARN": secret.arn, "Name": name}
    if version_id:
        result["VersionId"] = version_id
    return _json_response(result)


async def _handle_get_secret_value(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    version_id = body.get("VersionId")
    version_stage = body.get("VersionStage", "AWSCURRENT")

    secret = _find_secret(state, secret_id)
    if secret is None or secret.deleted_date is not None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )

    version = _resolve_version(secret, version_id, version_stage)
    if version is None:
        return _error_response(
            "ResourceNotFoundException",
            f"No version found for secret {secret_id}.",
        )

    result: dict[str, Any] = {
        "ARN": secret.arn,
        "Name": secret.name,
        "VersionId": version.version_id,
        "VersionStages": version.stages,
        "CreatedDate": version.created_date,
    }
    if version.secret_string is not None:
        result["SecretString"] = version.secret_string
    if version.secret_binary is not None:
        result["SecretBinary"] = version.secret_binary
    return _json_response(result)


async def _handle_put_secret_value(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    secret_string = body.get("SecretString")
    secret_binary = body.get("SecretBinary")

    secret = _find_secret(state, secret_id)
    if secret is None or secret.deleted_date is not None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )

    version_id = _rotate_secret_version(secret, secret_string, secret_binary)
    secret.last_changed_date = time.time()

    return _json_response({"ARN": secret.arn, "Name": secret.name, "VersionId": version_id})


async def _handle_update_secret(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    description = body.get("Description")
    secret_string = body.get("SecretString")
    secret_binary = body.get("SecretBinary")

    secret = _find_secret(state, secret_id)
    if secret is None or secret.deleted_date is not None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )

    if description is not None:
        secret.description = description

    version_id: str | None = None
    if secret_string is not None or secret_binary is not None:
        version_id = _rotate_secret_version(secret, secret_string, secret_binary)

    secret.last_changed_date = time.time()
    result: dict[str, Any] = {"ARN": secret.arn, "Name": secret.name}
    if version_id:
        result["VersionId"] = version_id
    return _json_response(result)


async def _handle_delete_secret(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    force_delete = body.get("ForceDeleteWithoutRecovery", False)

    secret = _find_secret(state, secret_id)
    if secret is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )

    if force_delete:
        state.secrets.pop(secret.name, None)
    else:
        secret.deleted_date = time.time()

    return _json_response(
        {
            "ARN": secret.arn,
            "Name": secret.name,
            "DeletionDate": secret.deleted_date or time.time(),
        }
    )


async def _handle_describe_secret(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    secret = _find_secret(state, secret_id)
    if secret is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )
    return _json_response(_format_secret_description(secret))


async def _handle_list_secrets(state: _SecretsState, body: dict) -> Response:
    include_planned_deletion = body.get("IncludePlannedDeletion", False)
    secrets = [
        _format_secret_description(s)
        for s in state.secrets.values()
        if s.deleted_date is None or include_planned_deletion
    ]
    return _json_response({"SecretList": secrets})


async def _handle_restore_secret(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    secret = _find_secret(state, secret_id)
    if secret is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )
    if secret.deleted_date is None:
        return _error_response(
            "InvalidRequestException",
            f"Secret {secret_id} is not scheduled for deletion.",
        )
    secret.deleted_date = None
    return _json_response({"ARN": secret.arn, "Name": secret.name})


async def _handle_tag_resource(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    tags_list = body.get("Tags", [])

    secret = _find_secret(state, secret_id)
    if secret is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )

    for tag in tags_list:
        secret.tags[tag["Key"]] = tag["Value"]
    return _json_response({})


async def _handle_untag_resource(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    tag_keys = body.get("TagKeys", [])

    secret = _find_secret(state, secret_id)
    if secret is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )

    for key in tag_keys:
        secret.tags.pop(key, None)
    return _json_response({})


async def _handle_get_resource_policy(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    secret = _find_secret(state, secret_id)
    if secret is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )
    return _json_response({"ARN": secret.arn, "Name": secret.name})


async def _handle_list_secret_version_ids(state: _SecretsState, body: dict) -> Response:
    secret_id = body.get("SecretId", "")
    secret = _find_secret(state, secret_id)
    if secret is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Secret {secret_id} not found.",
        )

    versions = [
        {
            "VersionId": v.version_id,
            "VersionStages": v.stages,
            "CreatedDate": v.created_date,
        }
        for v in secret.versions.values()
    ]
    return _json_response({"ARN": secret.arn, "Name": secret.name, "Versions": versions})


_ACTION_HANDLERS: dict[str, Any] = {
    "CreateSecret": _handle_create_secret,
    "GetSecretValue": _handle_get_secret_value,
    "PutSecretValue": _handle_put_secret_value,
    "UpdateSecret": _handle_update_secret,
    "DeleteSecret": _handle_delete_secret,
    "DescribeSecret": _handle_describe_secret,
    "ListSecrets": _handle_list_secrets,
    "RestoreSecret": _handle_restore_secret,
    "TagResource": _handle_tag_resource,
    "UntagResource": _handle_untag_resource,
    "ListSecretVersionIds": _handle_list_secret_version_ids,
    "GetResourcePolicy": _handle_get_resource_policy,
}
