"""FastAPI middleware for structured request logging.

Provides a reusable middleware that logs all HTTP requests with timing,
status codes, and structured metadata for WebSocket streaming to the GUI.
"""

from __future__ import annotations

import time
from collections.abc import Callable

from fastapi import Request, Response
from starlette.middleware.base import BaseHTTPMiddleware

from lws.logging.logger import LdkLogger


async def _get_request_body(request: Request) -> str | None:
    """Safely extract and cache request body without consuming the stream."""
    try:
        body_bytes = await request.body()
        if len(body_bytes) < 10240:  # 10KB limit
            return body_bytes.decode("utf-8", errors="replace")
    except Exception:
        pass
    return None


def _get_response_body(response: Response) -> str | None:
    """Extract response body if available."""
    try:
        if hasattr(response, "body") and response.body:
            if len(response.body) < 10240:  # 10KB limit
                return response.body.decode("utf-8", errors="replace")
    except Exception:
        pass
    return None


class RequestLoggingMiddleware(BaseHTTPMiddleware):
    """Middleware that logs all HTTP requests with timing and status.

    For each request:
    - Records start time
    - Calls the next handler
    - Logs method, path, duration, and status code
    - Uses structured logging for terminal and WebSocket output

    Args:
        app: The FastAPI application to wrap.
        logger: LdkLogger instance for structured logging.
        service_name: Optional service name to include in logs (e.g., "dynamodb", "sqs").
    """

    def __init__(
        self,
        app,
        logger: LdkLogger,
        service_name: str | None = None,
    ) -> None:
        super().__init__(app)
        self._logger = logger
        self._service_name = service_name

    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        """Process request, time it, log it, and return response."""
        # Skip logging for Chrome DevTools and other well-known paths
        if request.url.path.startswith("/.well-known/"):
            return await call_next(request)

        # Capture request body (limit to 10KB for logging)
        request_body = None
        if request.method in ("POST", "PUT", "PATCH"):
            request_body = await _get_request_body(request)

        t0 = time.monotonic()
        response = await call_next(request)
        duration_ms = (time.monotonic() - t0) * 1000

        # Capture response body by reading the stream (for StreamingResponse)
        response, response_body = await self._capture_response_body(response)

        # Extract operation name from path or headers (service-specific)
        operation = self._extract_operation(request, request_body)

        iam_eval = getattr(request.state, "iam_eval", None)
        self._logger.log_http_request(
            method=request.method,
            path=request.url.path,
            handler_name=operation or self._service_name or "handler",
            duration_ms=duration_ms,
            status_code=response.status_code,
            service=self._service_name,
            request_body=request_body,
            response_body=response_body,
            iam_eval=iam_eval,
        )

        return response

    @staticmethod
    async def _capture_response_body(response: Response) -> tuple[Response, str | None]:
        """Read the streaming response body and return a new response with the captured body.

        Returns a tuple of (response, response_body_str). If body reading fails,
        the original response is returned with None as the body string.
        """
        try:
            body_chunks = []
            async for chunk in response.body_iterator:
                body_chunks.append(chunk)
                if sum(len(c) for c in body_chunks) > 10240:  # 10KB limit
                    break

            body_bytes = b"".join(body_chunks)
            body_str = None
            if len(body_bytes) < 10240:
                body_str = body_bytes.decode("utf-8", errors="replace") or ""

            from starlette.responses import (  # pylint: disable=import-outside-toplevel
                Response as StarletteResponse,
            )

            new_response = StarletteResponse(
                content=body_bytes,
                status_code=response.status_code,
                headers=dict(response.headers),
                media_type=response.media_type,
            )
            return new_response, body_str
        except Exception:
            return response, None

    _TARGET_PREFIXES = (
        "DynamoDB",
        "AWSEvents",
        "AWSStepFunctions",
        "AWSCognitoIdentityProviderService",
    )

    def _extract_operation(self, request: Request, request_body: str | None = None) -> str | None:
        """Extract operation name from request (service-specific heuristics)."""
        # DynamoDB, EventBridge, Step Functions, Cognito: X-Amz-Target header
        target = request.headers.get("X-Amz-Target", "")
        if "." in target:
            for prefix in self._TARGET_PREFIXES:
                if prefix in target:
                    return target.split(".")[-1]

        # SQS/SNS: Action query parameter or form data
        action = request.query_params.get("Action")
        if action:
            return action

        # Check form data if available (for SQS/SNS POST requests)
        if request_body and "Action=" in request_body:
            # Parse simple form data to extract Action
            for part in request_body.split("&"):
                if part.startswith("Action="):
                    return part.split("=", 1)[1]

        # S3/API Gateway: Just use the path
        return None
