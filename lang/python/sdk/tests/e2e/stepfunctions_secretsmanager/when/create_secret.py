"""When: a secret is created in Secrets Manager"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSecretsmanagerTestClient
from ..constants import TEST_SECRET, TEST_SECRET_VALUE


@when("a secret is created in Secrets Manager")
def create_secret(lws_session, world):
    try:
        world["result"] = StepfunctionsSecretsmanagerTestClient(
            lws_session
        )._sm_client.create_secret(Name=TEST_SECRET, SecretString=TEST_SECRET_VALUE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
