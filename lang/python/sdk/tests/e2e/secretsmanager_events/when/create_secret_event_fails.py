"""When: a secret is created but the "CREATED" event delivery fails because the bus is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET, TEST_SECRET_VALUE


@when('a secret is created but the "CREATED" event delivery fails because the bus is deleted')
def create_secret_event_fails(lws_session, world):
    try:
        world["result"] = lws_session.client("secretsmanager").create_secret(
            Name=TEST_SECRET, SecretString=TEST_SECRET_VALUE
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
