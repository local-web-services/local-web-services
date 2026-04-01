"""When: a "secrets manager" "secret" is described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET


@when('a "secrets manager" "secret" is described')
def describe_secret(lws_session, world):
    try:
        resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
