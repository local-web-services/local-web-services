"""When: a "secretsmanager" "secret" is created in Secrets Manager"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaSecretsmanagerTestClient
from ..constants import TEST_SECRET


@when('a "secretsmanager" "secret" is created in Secrets Manager')
def create_secret(lws_session, world):
    try:
        LambdaSecretsmanagerTestClient(lws_session).create_secret()
        world["result"] = {"Name": TEST_SECRET}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
