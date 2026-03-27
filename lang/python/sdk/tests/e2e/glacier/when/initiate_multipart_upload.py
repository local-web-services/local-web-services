"""When: a multipart upload is initiated for a vault"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PART_SIZE, TEST_VAULT


@when("a multipart upload is initiated for a vault")
def initiate_multipart_upload(lws_session, world):
    try:
        result = lws_session.client("glacier").initiate_multipart_upload(
            accountId="-",
            vaultName=world.get("vault_name", TEST_VAULT),
            partSize=str(TEST_PART_SIZE),
        )
        world["result"] = result
        world["upload_id"] = result.get("uploadId")
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
