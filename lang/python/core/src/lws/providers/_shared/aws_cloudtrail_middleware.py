"""CloudTrail event-capture middleware for AWS service providers.

Intercepts every request/response pair and records a CloudTrail event into
the shared ``CloudTrailProvider`` buffer.  When no provider is registered this
middleware is a no-op — it never raises and never delays the request.

Placement: added as the **innermost** middleware (closest to the route handler)
so that the event envelope captures the final response after all other
middleware (IAM auth, chaos, fakes) have already acted.
"""

from __future__ import annotations

import logging
from typing import TYPE_CHECKING, Any

from starlette.middleware.base import BaseHTTPMiddleware, RequestResponseEndpoint
from starlette.requests import Request
from starlette.responses import Response

from lws.providers._shared.aws_operation_fake import extract_operation_from_request
from lws.providers.cloudtrail._event_builder import build_cloudtrail_event

if TYPE_CHECKING:
    from lws.interfaces.cloudtrail import ICloudTrail

_logger = logging.getLogger(__name__)


def _kebab_to_pascal(name: str) -> str:
    """Convert ``create-queue`` → ``CreateQueue`` for CloudTrail event names."""
    return "".join(word.capitalize() for word in name.split("-"))


def _extract_username(request: Request) -> str:
    """Derive a best-effort username from the Authorization header."""
    auth = request.headers.get("authorization", "")
    if "Credential=" in auth:
        try:
            cred_part = auth.split("Credential=")[1].split(",")[0]
            return cred_part.split("/")[0]
        except (IndexError, ValueError):
            pass
    return "anonymous"


def _extract_error(response: Response) -> tuple[str | None, str | None]:
    """Try to extract errorCode/errorMessage from a 4xx/5xx JSON response body."""
    if response.status_code < 400:
        return None, None
    try:
        import json  # pylint: disable=import-outside-toplevel

        body = b""
        if hasattr(response, "body"):
            body = response.body
        if not body:
            return str(response.status_code), None
        data = json.loads(body)
        code = data.get("__type") or data.get("Code") or data.get("code")
        msg = data.get("message") or data.get("Message") or data.get("Error", {}).get("Message")
        return code, msg
    except Exception:  # pylint: disable=broad-except
        return str(response.status_code), None


class AwsCloudTrailMiddleware(BaseHTTPMiddleware):
    """ASGI middleware that records CloudTrail events for every AWS API call."""

    def __init__(
        self,
        app: Any,
        *,
        service: str,
        cloudtrail_provider: ICloudTrail | None,
    ) -> None:
        super().__init__(app)
        self._service = service
        self._provider = cloudtrail_provider

    async def dispatch(self, request: Request, call_next: RequestResponseEndpoint) -> Response:
        """Forward request then record the resulting CloudTrail event."""
        if self._provider is None or request.url.path.startswith("/_ldk/"):
            return await call_next(request)

        operation = await extract_operation_from_request(request, self._service)
        response = await call_next(request)

        if operation is None:
            return response

        try:
            error_code, error_message = _extract_error(response)
            username = _extract_username(request)
            source_ip = request.client.host if request.client else "127.0.0.1"
            event = build_cloudtrail_event(
                service=self._service,
                operation=_kebab_to_pascal(operation),
                source_ip=source_ip,
                username=username,
                status_code=response.status_code,
                error_code=error_code,
                error_message=error_message,
            )
            self._provider.record_event(event)
        except Exception as exc:  # pylint: disable=broad-except
            _logger.debug("CloudTrail middleware: failed to record event: %s", exc)

        return response


def apply_cloudtrail_middleware(app: Any, provider: ICloudTrail | None, service: str) -> None:
    """Add ``AwsCloudTrailMiddleware`` as the innermost middleware on *app*.

    Calling ``app.add_middleware(...)`` prepends to the chain, so the last
    call is the innermost layer — closest to the route handler.  Call this
    function **after** all other ``app.add_middleware(...)`` calls.
    """
    app.add_middleware(AwsCloudTrailMiddleware, service=service, cloudtrail_provider=provider)
