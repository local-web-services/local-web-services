"""When: a deleted secret is restored within the recovery window"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET


@when("a deleted secret is restored within the recovery window")
def restore_secret(lws_session, world):
    try:
        resp = lws_session.client("secretsmanager").restore_secret(SecretId=TEST_SECRET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
