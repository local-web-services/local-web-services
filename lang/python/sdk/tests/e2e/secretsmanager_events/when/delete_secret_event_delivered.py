"""
When: a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the
bus
"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SecretsmanagerEventsTestClient
from ..constants import TEST_SECRET


@when(
    'a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus'
)
def delete_secret_event_delivered(lws_session, world):
    try:
        world["result"] = SecretsmanagerEventsTestClient(lws_session)._sm.delete_secret(
            SecretId=TEST_SECRET
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
