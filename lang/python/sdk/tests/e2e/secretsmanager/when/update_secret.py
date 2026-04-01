"""When: metadata or description for an active "secrets manager" "secret" is updated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DESCRIPTION, TEST_SECRET


@when('metadata or description for an active "secrets manager" "secret" is updated')
def update_secret(lws_session, world):
    try:
        resp = lws_session.client("secretsmanager").update_secret(
            SecretId=TEST_SECRET, Description=TEST_DESCRIPTION
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
