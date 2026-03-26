"""Then: the replication group is in "CREATING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..client import ElasticacheTestClient
from ..constants import TEST_REPLICATION_GROUP


@then('the replication group is in "CREATING" state')
def rg_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = ElasticacheTestClient(lws_session).describe_replication_groups(
        ReplicationGroupId=TEST_REPLICATION_GROUP
    )
    actual_groups = resp.get("ReplicationGroups", [])
    assert (
        len(actual_groups) > 0
    ), f"Expected replication group '{TEST_REPLICATION_GROUP}' to exist but found none"
