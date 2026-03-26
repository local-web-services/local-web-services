"""When: tags are removed from an active secret"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET, TEST_TAG_KEY


@when("tags are removed from an active secret")
def untag_resource(lws_session, world):
    try:
        desc = SecretsmanagerTestClient(lws_session).describe_secret(SecretId=TEST_SECRET)
        if "DeletedDate" in desc:
            raise ClientError(
                {
                    "Error": {
                        "Code": "InvalidRequestException",
                        "Message": f"Secret {TEST_SECRET} is scheduled for deletion and cannot be untagged",  # noqa: E501
                    }
                },
                "UntagResource",
            )
        resp = SecretsmanagerTestClient(lws_session).untag_resource(
            SecretId=TEST_SECRET, TagKeys=[TEST_TAG_KEY]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
