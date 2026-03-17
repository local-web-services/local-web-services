"""IAM management stub HTTP routes.

Implements the IAM Action-based form-encoded API that AWS SDKs and
Terraform use.  All operations store state in memory and return valid
XML responses so that ``terraform apply`` succeeds.
"""

from __future__ import annotations

from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers.iam._iam_handlers import (
    _ACTION_HANDLERS,
    _request_id,
    _xml_response,  # noqa: F401
)
from lws.providers.iam._iam_state import _IamState

_logger = get_logger("ldk.iam")


async def _parse_form(request: Request) -> dict[str, str]:
    """Parse the form-encoded body of an IAM request."""
    form = await request.form()
    return {k: str(v) for k, v in form.items()}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def _check_iam_get_role_lifecycle(
    action: str, params: dict, lc: ResourceLifecycleConfig, tracker: ResourceStateTracker
) -> Response | None:
    """Check lifecycle state for GetRole requests."""
    if not lc.enabled or action != "GetRole":
        return None
    role_name = params.get("RoleName", "")
    role_state = tracker.get_state(role_name)
    if role_state not in ("CREATING", "DELETING"):
        return None
    xml = (
        "<ErrorResponse>"
        "<Error><Code>NoSuchEntity</Code>"
        f"<Message>The role with name {role_name} cannot be found"
        f" (status: {role_state}).</Message>"
        "</Error>"
        f"<RequestId>{_request_id()}</RequestId>"
        "</ErrorResponse>"
    )
    return Response(content=xml, status_code=404, media_type="text/xml")


async def _handle_iam_lifecycle(
    action: str,
    handler: Any,
    state: _IamState,
    params: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Handle lifecycle-aware IAM operations. Returns None to fall through."""
    if action == "CreateRole" and lc.create_dwell_ms > 0:
        return await _lifecycle_create_role(handler, state, params, lc, tracker)
    if action == "DeleteRole":
        return await _lifecycle_delete_role(handler, state, params, lc, tracker)
    return None


async def _lifecycle_create_role(
    handler: Any,
    state: _IamState,
    params: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle for CreateRole."""
    resp = await handler(state, params)
    if resp.status_code == 200:
        role_name = params.get("RoleName", "")
        tracker.set_state(role_name, "CREATING")
        tracker.schedule_transition(role_name, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _lifecycle_delete_role(
    handler: Any,
    state: _IamState,
    params: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle for DeleteRole."""
    role_name = params.get("RoleName", "")
    if tracker.get_state(role_name) == "CREATING":
        xml = (
            "<ErrorResponse>"
            "<Error><Code>DeleteConflict</Code>"
            f"<Message>Role {role_name} is still being created</Message>"
            "</Error>"
            f"<RequestId>{_request_id()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=409, media_type="text/xml")
    resp = await handler(state, params)
    if resp.status_code == 200:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(role_name, "DELETING")
            tracker.schedule_transition(role_name, None, lc.delete_dwell_ms)
        else:
            tracker.remove(role_name)
    return resp


async def _iam_dispatch(
    request: Request,
    state: _IamState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Route a single IAM request."""
    params = await _parse_form(request)
    action = params.get("Action", "")

    err = _check_iam_get_role_lifecycle(action, params, lc, tracker)
    if err is not None:
        return err

    handler = _ACTION_HANDLERS.get(action)
    if handler is None:
        _logger.warning("Unknown IAM action: %s", action)
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Type>Sender</Type>"
            "<Code>InvalidAction</Code>"
            f"<Message>lws: IAM operation '{action}' is not yet implemented</Message>"
            "</Error>"
            f"<RequestId>{_request_id()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=400, media_type="text/xml")

    if lc.enabled:
        result = await _handle_iam_lifecycle(action, handler, state, params, lc, tracker)
        if result is not None:
            return result

    return await handler(state, params)


def create_iam_app(
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the IAM wire protocol."""
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)

    app = FastAPI(title="LDK IAM")
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="iam")
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.XML_IAM)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="iam")
    state = _IamState()

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await _iam_dispatch(request, state, _lc, _tracker)

    return app
