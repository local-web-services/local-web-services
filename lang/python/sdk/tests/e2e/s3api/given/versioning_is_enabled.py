"""Given: versioning is enabled"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@given("versioning is enabled")
def versioning_is_enabled(lws_session):
    S3apiTestClient(lws_session).put_bucket_versioning(
        Bucket=TEST_BUCKET, VersioningConfiguration={"Status": "Enabled"}
    )
