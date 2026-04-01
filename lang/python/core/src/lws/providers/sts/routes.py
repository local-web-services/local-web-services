"""STS stub HTTP routes.

Implements the STS Action-based form-encoded API.  Only
``GetCallerIdentity`` is needed for Terraform to succeed.
"""

from __future__ import annotations

import re
import uuid
from datetime import UTC, datetime

from fastapi import FastAPI, Request, Response

from lws.interfaces.cloudtrail import ICloudTrail  # noqa: TC001
from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware

_logger = get_logger("ldk.sts")

_ACCOUNT_ID = "000000000000"
_TOKEN_RE = re.compile(r"^lws-acct-(\d{12})-")


async def _parse_form(request: Request) -> dict[str, str]:
    """Parse the form-encoded body of an STS request."""
    form = await request.form()
    return {k: str(v) for k, v in form.items()}


def _request_id() -> str:
    return str(uuid.uuid4())


def _extract_account_from_token(token: str) -> str:
    """Return the account ID embedded in an lws-acct-* session token, or the default."""
    match = _TOKEN_RE.match(token)
    return match.group(1) if match else _ACCOUNT_ID


async def _handle_get_caller_identity(params: dict[str, str]) -> Response:
    token = params.get("_security_token", "")
    account_id = _extract_account_from_token(token) if token else _ACCOUNT_ID
    xml = (
        '<GetCallerIdentityResponse xmlns="https://sts.amazonaws.com/doc/2011-06-15/">'
        "<GetCallerIdentityResult>"
        f"<Arn>arn:aws:iam::{account_id}:root</Arn>"
        f"<UserId>{account_id}</UserId>"
        f"<Account>{account_id}</Account>"
        "</GetCallerIdentityResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</GetCallerIdentityResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_assume_role(params: dict[str, str]) -> Response:
    role_arn = params.get("RoleArn", f"arn:aws:iam::{_ACCOUNT_ID}:role/assumed-role")
    session_name = params.get("RoleSessionName", "session")
    duration = int(params.get("DurationSeconds", "3600"))

    arn_parts = role_arn.split(":")
    account_id = arn_parts[4] if len(arn_parts) >= 5 else _ACCOUNT_ID

    access_key_id = "ASIALWSLOCALKEY"
    secret_access_key = "lws-local-secret"
    session_token = f"lws-acct-{account_id}-{uuid.uuid4()}"
    expiration = datetime.fromtimestamp(datetime.now(UTC).timestamp() + duration, tz=UTC).strftime(
        "%Y-%m-%dT%H:%M:%SZ"
    )

    xml = (
        '<AssumeRoleResponse xmlns="https://sts.amazonaws.com/doc/2011-06-15/">'
        "<AssumeRoleResult>"
        "<AssumedRoleUser>"
        f"<AssumedRoleId>{account_id}:{session_name}</AssumedRoleId>"
        f"<Arn>{role_arn}</Arn>"
        "</AssumedRoleUser>"
        "<Credentials>"
        f"<AccessKeyId>{access_key_id}</AccessKeyId>"
        f"<SecretAccessKey>{secret_access_key}</SecretAccessKey>"
        f"<SessionToken>{session_token}</SessionToken>"
        f"<Expiration>{expiration}</Expiration>"
        "</Credentials>"
        "</AssumeRoleResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</AssumeRoleResponse>"
    )
    return Response(content=xml, media_type="text/xml")


_ACTION_HANDLERS = {
    "GetCallerIdentity": _handle_get_caller_identity,
    "AssumeRole": _handle_assume_role,
}


def create_sts_app(
    cloudtrail_provider: ICloudTrail | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the STS wire protocol."""
    app = FastAPI(title="LDK STS")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="sts")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        params = await _parse_form(request)
        params["_security_token"] = request.headers.get("X-Amz-Security-Token", "")
        action = params.get("Action", "")
        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            _logger.warning("Unknown STS action: %s", action)
            xml = (
                "<ErrorResponse>"
                "<Error>"
                "<Type>Sender</Type>"
                "<Code>InvalidAction</Code>"
                f"<Message>lws: STS operation '{action}' is not yet implemented</Message>"
                "</Error>"
                f"<RequestId>{_request_id()}</RequestId>"
                "</ErrorResponse>"
            )
            return Response(content=xml, status_code=400, media_type="text/xml")

        return await handler(params)

    apply_cloudtrail_middleware(app, cloudtrail_provider, "sts")
    return app
