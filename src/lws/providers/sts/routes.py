"""STS stub HTTP routes.

Implements the STS Action-based form-encoded API.  Only
``GetCallerIdentity`` is needed for Terraform to succeed.
"""

from __future__ import annotations

import uuid

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware

_logger = get_logger("ldk.sts")

_ACCOUNT_ID = "000000000000"


async def _parse_form(request: Request) -> dict[str, str]:
    """Parse the form-encoded body of an STS request."""
    form = await request.form()
    return {k: str(v) for k, v in form.items()}


def _request_id() -> str:
    return str(uuid.uuid4())


async def _handle_get_caller_identity(_params: dict[str, str]) -> Response:
    xml = (
        '<GetCallerIdentityResponse xmlns="https://sts.amazonaws.com/doc/2011-06-15/">'
        "<GetCallerIdentityResult>"
        f"<Arn>arn:aws:iam::{_ACCOUNT_ID}:root</Arn>"
        f"<UserId>{_ACCOUNT_ID}</UserId>"
        f"<Account>{_ACCOUNT_ID}</Account>"
        "</GetCallerIdentityResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</GetCallerIdentityResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_assume_role(params: dict[str, str]) -> Response:
    role_arn = params.get("RoleArn", f"arn:aws:iam::{_ACCOUNT_ID}:role/assumed-role")
    session_name = params.get("RoleSessionName", "session")
    access_key_id = "ASIALWSLOCALKEY"
    secret_access_key = "lws-local-secret"
    session_token = f"lws-session-token-{uuid.uuid4()}"
    xml = (
        '<AssumeRoleResponse xmlns="https://sts.amazonaws.com/doc/2011-06-15/">'
        "<AssumeRoleResult>"
        "<AssumedRoleUser>"
        f"<AssumedRoleId>{_ACCOUNT_ID}:{session_name}</AssumedRoleId>"
        f"<Arn>{role_arn}</Arn>"
        "</AssumedRoleUser>"
        "<Credentials>"
        f"<AccessKeyId>{access_key_id}</AccessKeyId>"
        f"<SecretAccessKey>{secret_access_key}</SecretAccessKey>"
        f"<SessionToken>{session_token}</SessionToken>"
        "<Expiration>2099-12-31T23:59:59Z</Expiration>"
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


def create_sts_app() -> FastAPI:
    """Create a FastAPI application that speaks the STS wire protocol."""
    app = FastAPI(title="LDK STS")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="sts")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        params = await _parse_form(request)
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

    return app
