"""When: a "secretsmanager" "secret" is created in Secrets Manager"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET, TEST_SECRET_VALUE


@when('a "secretsmanager" "secret" is created in Secrets Manager')
def create_secret_sm(lws_session, world):
    try:
        resp = lws_session.client("secretsmanager").create_secret(
            Name=TEST_SECRET, SecretString=TEST_SECRET_VALUE
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
