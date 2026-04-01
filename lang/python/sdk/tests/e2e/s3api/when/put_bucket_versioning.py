"""When: versioning is configured on a "s3" "bucket" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET


@when('versioning is configured on a "s3" "bucket"')
def put_bucket_versioning(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").put_bucket_versioning(
            Bucket=TEST_BUCKET, VersioningConfiguration={"Status": "Enabled"}
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
