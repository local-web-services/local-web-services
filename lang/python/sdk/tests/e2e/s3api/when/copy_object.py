"""When: an object is copied from one bucket to another"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY, TEST_KEY2, TEST_SRC_BUCKET


@when("an object is copied from one bucket to another")
def copy_object(lws_session, world):
    try:
        world["result"] = S3apiTestClient(lws_session).copy_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY2,
            CopySource={"Bucket": TEST_SRC_BUCKET, "Key": TEST_KEY},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
