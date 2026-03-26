"""When: a secret is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET, TEST_VALUE


@when("a secret is created")
def create_secret(lws_session, world):
    try:
        resp = lws_session.client("secretsmanager").create_secret(
            Name=TEST_SECRET, SecretString=TEST_VALUE
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
