"""When: a new value is stored for an active "secrets manager" "secret" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET, TEST_VALUE2


@when('a new value is stored for an active "secrets manager" "secret"')
def put_secret_value(lws_session, world):
    try:
        resp = lws_session.client("secretsmanager").put_secret_value(
            SecretId=TEST_SECRET, SecretString=TEST_VALUE2
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
