"""
When: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the
bus
"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET


@when(
    'a "secretsmanager" "secret" is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus'
)
def delete_secret_event_delivered(lws_session, world):
    try:
        world["result"] = lws_session.client("secretsmanager").delete_secret(SecretId=TEST_SECRET)
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
        return
    if lws_session.capacity("events").is_exhausted():
        world["result"] = None
        world["error"] = Exception("lws: event capacity exhausted")
        return
    world["error"] = None
