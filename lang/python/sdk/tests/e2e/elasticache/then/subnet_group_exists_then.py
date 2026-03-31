"""Then: the "elasticache" subnet group will exist"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..constants import TEST_SUBNET_GROUP


@then('the "elasticache" subnet group will exist')
def subnet_group_exists_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = lws_session.client("elasticache").describe_cache_subnet_groups(
        CacheSubnetGroupName=TEST_SUBNET_GROUP
    )
    actual_groups = resp.get("CacheSubnetGroups", [])
    assert (
        len(actual_groups) > 0
    ), f"Expected subnet group '{TEST_SUBNET_GROUP}' to exist but found none"
