"""When: the current value of an active secret is retrieved"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET


@when("the current value of an active secret is retrieved")
def get_secret_value(lws_session, world):
    try:
        resp = SecretsmanagerTestClient(lws_session).get_secret_value(SecretId=TEST_SECRET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
