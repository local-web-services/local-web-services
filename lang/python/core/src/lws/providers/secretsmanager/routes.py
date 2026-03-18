"""Secrets Manager HTTP routes.

Implements the Secrets Manager wire protocol that AWS SDKs and Terraform use,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

import json
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
from lws.providers.secretsmanager._secretsmanager_handlers import (  # pylint: disable=unused-import
    _ACTION_HANDLERS,
    _error_response,
    _json_response,  # noqa: F401
)
from lws.providers.secretsmanager._secretsmanager_state import (
    _Secret,
    _SecretsState,
    _SecretVersion,
)

_logger = get_logger("ldk.secretsmanager")


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

    if lc.enabled:
        result = await _handle_secretsmanager_lifecycle(action, handler, state, body, lc, tracker)
        if result is not None:
            return result

    return await handler(state, body)


async def _handle_secretsmanager_lifecycle(
    action: str,
    handler: Any,
    state: _SecretsState,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    if action == "CreateSecret" and lc.create_dwell_ms > 0:
        return await _lifecycle_create_secret(handler, state, body, lc, tracker)
    if action == "DeleteSecret":
        return await _lifecycle_delete_secret(handler, state, body, lc, tracker)
    return None


async def _lifecycle_create_secret(
    handler: Any,
    state: _SecretsState,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    resp = await handler(state, body)
    if resp.status_code == 200:
        secret_name = body.get("Name", "")
        tracker.set_state(secret_name, "CREATING")
        tracker.schedule_transition(secret_name, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _lifecycle_delete_secret(
    handler: Any,
    state: _SecretsState,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
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
