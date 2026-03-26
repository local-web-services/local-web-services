"""Given: versioning is not disabled"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@given("versioning is not disabled")
def versioning_is_not_disabled(lws_session):
    S3apiTestClient(lws_session).put_bucket_versioning(
        Bucket=TEST_BUCKET, VersioningConfiguration={"Status": "Enabled"}
    )
