"""Secrets Manager HTTP routes.

Implements the Secrets Manager wire protocol that AWS SDKs and Terraform use,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

import json
import time
import uuid
from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action

_logger = get_logger("ldk.secretsmanager")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _SecretVersion:
    """A single version of a secret."""

    def __init__(
        self,
        version_id: str,
        secret_string: str | None = None,
        secret_binary: str | None = None,
        stages: list[str] | None = None,
    ) -> None:
        self.version_id = version_id
        self.secret_string = secret_string
        self.secret_binary = secret_binary
        self.stages = stages or ["AWSCURRENT"]
        self.created_date: float = time.time()


class _Secret:
    """Represents a Secrets Manager secret."""

    def __init__(
        self,
        name: str,
        description: str = "",
        tags: dict[str, str] | None = None,
    ) -> None:
        self.name = name
        self.arn = f"arn:aws:secretsmanager:{_REGION}:{_ACCOUNT_ID}:secret:{name}"
        self.description = description
        self.tags: dict[str, str] = tags or {}
        self.versions: dict[str, _SecretVersion] = {}
        self.current_version_id: str | None = None
        self.deleted_date: float | None = None
        self.created_date: float = time.time()
        self.last_changed_date: float = time.time()


class _SecretsState:
    """In-memory store for Secrets Manager secrets."""

    def __init__(self) -> None:
        self._secrets: dict[str, _Secret] = {}

    @property
    def secrets(self) -> dict[str, _Secret]:
        """Return the secrets store."""
        return self._secrets

    def reset(self) -> None:
        """Clear all secrets from the store."""
        self._secrets.clear()


# ------------------------------------------------------------------
# Action handlers
# ------------------------------------------------------------------


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
        version_id = str(uuid.uuid4())
        version = _SecretVersion(
            version_id=version_id,
            secret_string=secret_string,
            secret_binary=secret_binary,
            stages=["AWSCURRENT"],
        )
        secret.versions[version_id] = version
        secret.current_version_id = version_id

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

    # Move AWSCURRENT from old version
    if secret.current_version_id and secret.current_version_id in secret.versions:
        old = secret.versions[secret.current_version_id]
        if "AWSCURRENT" in old.stages:
            old.stages.remove("AWSCURRENT")
        if "AWSPREVIOUS" not in old.stages:
            old.stages.append("AWSPREVIOUS")

    version_id = str(uuid.uuid4())
    version = _SecretVersion(
        version_id=version_id,
        secret_string=secret_string,
        secret_binary=secret_binary,
        stages=["AWSCURRENT"],
    )
    secret.versions[version_id] = version
    secret.current_version_id = version_id
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


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _rotate_secret_version(
    secret: _Secret,
    secret_string: str | None,
    secret_binary: str | None,
) -> str:
    """Rotate the AWSCURRENT version and create a new one. Returns the new version_id."""
    # Move AWSCURRENT from old version to AWSPREVIOUS
    if secret.current_version_id and secret.current_version_id in secret.versions:
        old = secret.versions[secret.current_version_id]
        if "AWSCURRENT" in old.stages:
            old.stages.remove("AWSCURRENT")
        if "AWSPREVIOUS" not in old.stages:
            old.stages.append("AWSPREVIOUS")

    version_id = str(uuid.uuid4())
    version = _SecretVersion(
        version_id=version_id,
        secret_string=secret_string,
        secret_binary=secret_binary,
        stages=["AWSCURRENT"],
    )
    secret.versions[version_id] = version
    secret.current_version_id = version_id
    return version_id


def _find_secret(state: _SecretsState, secret_id: str) -> _Secret | None:
    """Find a secret by name or ARN."""
    if secret_id in state.secrets:
        return state.secrets[secret_id]
    for s in state.secrets.values():
        if s.arn == secret_id:
            return s
    return None


def _resolve_version(
    secret: _Secret,
    version_id: str | None,
    version_stage: str,
) -> _SecretVersion | None:
    """Resolve a secret version by ID or stage."""
    if version_id:
        return secret.versions.get(version_id)
    for v in secret.versions.values():
        if version_stage in v.stages:
            return v
    return None


def _format_secret_description(secret: _Secret) -> dict[str, Any]:
    """Format a secret for DescribeSecret / ListSecrets response."""
    result: dict[str, Any] = {
        "ARN": secret.arn,
        "Name": secret.name,
        "Description": secret.description,
        "CreatedDate": secret.created_date,
        "LastChangedDate": secret.last_changed_date,
    }
    if secret.tags:
        result["Tags"] = [{"Key": k, "Value": v} for k, v in secret.tags.items()]
    if secret.deleted_date is not None:
        result["DeletedDate"] = secret.deleted_date
    # Version IDs to stages mapping
    if secret.versions:
        result["VersionIdsToStages"] = {v.version_id: v.stages for v in secret.versions.values()}
    return result


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


# ------------------------------------------------------------------
# Action dispatch table
# ------------------------------------------------------------------


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


# Actions that require the secret to be ACTIVE (not in a transient lifecycle state)
_SECRET_ID_ACTIONS = {
    "GetSecretValue",
    "DescribeSecret",
    "PutSecretValue",
    "UpdateSecret",
    "ListSecretVersionIds",
    "GetResourcePolicy",
    "TagResource",
    "UntagResource",
    "RestoreSecret",
}


def _check_secret_lifecycle(
    action: str,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    if not lc.enabled or action not in _SECRET_ID_ACTIONS:
        return None
    secret_id = body.get("SecretId", "")
    if not secret_id:
        return None
    secret_name = secret_id.rsplit(":", 1)[-1] if ":" in secret_id else secret_id
    state_val = tracker.get_state(secret_name)
    if state_val in ("CREATING", "DELETING"):
        return Response(
            content=json.dumps(
                {
                    "__type": "ResourceNotFoundException",
                    "message": f"Secret {secret_name} not found (status: {state_val})",
                }
            ),
            status_code=400,
            media_type="application/json",
        )
    return None


async def _secretsmanager_dispatch(
    request: Request,
    state: _SecretsState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    target = request.headers.get("x-amz-target", "")
    body = await parse_json_body(request)
    action = resolve_api_action(target, body)

    err = _check_secret_lifecycle(action, body, lc, tracker)
    if err is not None:
        return err

    handler = _ACTION_HANDLERS.get(action)
    if handler is None:
        _logger.warning("Unknown Secrets Manager action: %s", action)
        return _error_response(
            "InvalidAction",
            f"lws: Secrets Manager operation '{action}' is not yet implemented",
        )

    if action == "CreateSecret" and lc.enabled and lc.create_dwell_ms > 0:
        resp = await handler(state, body)
        if resp.status_code == 200:
            secret_name = body.get("Name", "")
            tracker.set_state(secret_name, "CREATING")
            tracker.schedule_transition(secret_name, "ACTIVE", lc.create_dwell_ms)
        return resp

    if action == "DeleteSecret" and lc.enabled:
        secret_id = body.get("SecretId", "")
        secret_name = secret_id.rsplit(":", 1)[-1] if ":" in secret_id else secret_id
        if tracker.get_state(secret_name) == "CREATING":
            return Response(
                content=json.dumps(
                    {
                        "__type": "ResourceInUseException",
                        "message": f"Secret {secret_id} is still being created",
                    }
                ),
                status_code=400,
                media_type="application/json",
            )
        resp = await handler(state, body)
        if resp.status_code == 200:
            if lc.delete_dwell_ms > 0:
                tracker.set_state(secret_name, "DELETING")
                tracker.schedule_transition(secret_name, None, lc.delete_dwell_ms)
            else:
                tracker.remove(secret_name)
        return resp

    return await handler(state, body)


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_secretsmanager_app(
    initial_secrets: list[dict] | None = None,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    state: _SecretsState | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
) -> tuple[FastAPI, _SecretsState]:
    """Create a FastAPI application that speaks the Secrets Manager wire protocol.

    Returns a tuple of (app, state) so callers can retain a reference to the
    state object for lifecycle management (e.g. reset).
    """
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)

    app = FastAPI(title="LDK Secrets Manager")
    if aws_fake is not None:
        app.add_middleware(
            AwsOperationFakeMiddleware, fake_config=aws_fake, service="secretsmanager"
        )
    add_iam_auth_middleware(app, "secretsmanager", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="secretsmanager")
    if state is None:
        state = _SecretsState()

    if initial_secrets:
        for s in initial_secrets:
            secret = _Secret(
                name=s["name"],
                description=s.get("description", ""),
            )
            secret_string = s.get("secret_string")
            if secret_string is not None:
                version_id = str(uuid.uuid4())
                version = _SecretVersion(
                    version_id=version_id,
                    secret_string=secret_string,
                    stages=["AWSCURRENT"],
                )
                secret.versions[version_id] = version
                secret.current_version_id = version_id
            state.secrets[secret.name] = secret

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await _secretsmanager_dispatch(request, state, _lc, _tracker)

    return app, state
