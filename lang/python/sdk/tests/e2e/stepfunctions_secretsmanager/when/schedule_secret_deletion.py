"""When: a secret is scheduled for deletion"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSecretsmanagerTestClient
from ..constants import TEST_SECRET


@when("a secret is scheduled for deletion")
def schedule_secret_deletion(lws_session, world):
    try:
        world["result"] = StepfunctionsSecretsmanagerTestClient(
            lws_session
        )._sm_client.delete_secret(SecretId=TEST_SECRET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
