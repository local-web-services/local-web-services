"""When: all "secrets manager" "secret"s are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('all "secrets manager" "secret"s are listed')
def list_secrets(lws_session, world):
    try:
        resp = lws_session.client("secretsmanager").list_secrets()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
