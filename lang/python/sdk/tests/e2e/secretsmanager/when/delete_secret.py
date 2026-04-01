"""When: a "secrets manager" "secret" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET


@when('a "secrets manager" "secret" is deleted')
def delete_secret(lws_session, world):
    try:
        desc = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
        if "DeletedDate" in desc:
            raise ClientError(
                {
                    "Error": {
                        "Code": "InvalidRequestException",
                        "Message": f"Secret {TEST_SECRET} is already scheduled for deletion",
                    }
                },
                "DeleteSecret",
            )
        resp = lws_session.client("secretsmanager").delete_secret(SecretId=TEST_SECRET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
