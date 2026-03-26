"""When: all secrets are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SecretsmanagerTestClient


@when("all secrets are listed")
def list_secrets(lws_session, world):
    try:
        resp = SecretsmanagerTestClient(lws_session).list_secrets()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
