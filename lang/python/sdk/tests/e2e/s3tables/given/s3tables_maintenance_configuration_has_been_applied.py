"""Given: maintenance configuration is applied to a "s3 tables" "table" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@given('maintenance configuration is applied to a "s3 tables" "table"')
def s3tables_maintenance_configuration_has_been_applied(lws_session):
    client = S3tablesTestClient(lws_session)
    bucket_arn = client.setup_bucket_namespace_table()
    client.put_table_maintenance_configuration(
        tableBucketARN=bucket_arn,
        namespace=TEST_NAMESPACE,
        name=TEST_TABLE,
        type="icebergCompaction",
        value={"status": "enabled"},
    )
