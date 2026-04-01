"""When: a "secretsmanager" "secret" is scheduled for deletion"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET


@when('a "secretsmanager" "secret" is scheduled for deletion')
def schedule_secret_deletion(lws_session, world):
    try:
        resp = lws_session.client("secretsmanager").delete_secret(
            SecretId=TEST_SECRET, RecoveryWindowInDays=7
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
