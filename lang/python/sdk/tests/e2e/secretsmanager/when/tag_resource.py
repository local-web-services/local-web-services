"""When: tags are added to an active secret"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET, TEST_TAG_KEY, TEST_TAG_VALUE


@when("tags are added to an active secret")
def tag_resource(lws_session, world):
    try:
        desc = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
        if "DeletedDate" in desc:
            raise ClientError(
                {
                    "Error": {
                        "Code": "InvalidRequestException",
                        "Message": f"Secret {TEST_SECRET} is scheduled for deletion and cannot be tagged",  # noqa: E501
                    }
                },
                "TagResource",
            )
        resp = lws_session.client("secretsmanager").tag_resource(
            SecretId=TEST_SECRET, Tags=[{"Key": TEST_TAG_KEY, "Value": TEST_TAG_VALUE}]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
