"""Given: versioning is configured on a "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@given('versioning is configured on a "s3" "bucket"')
def versioning_has_been_configured_on_a_bucket(lws_session):
    S3apiTestClient(lws_session).create_bucket()
    S3apiTestClient(lws_session).put_bucket_versioning(
        Bucket=TEST_BUCKET, VersioningConfiguration={"Status": "Enabled"}
    )
