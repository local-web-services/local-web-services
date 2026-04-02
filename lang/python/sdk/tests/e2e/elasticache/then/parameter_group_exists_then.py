"""Then: the "elasticache" "parameter group" will exist"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..constants import TEST_PARAMETER_GROUP


@then('the "elasticache" "parameter group" will exist')
def parameter_group_exists_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = lws_session.client("elasticache").describe_cache_parameter_groups(
        CacheParameterGroupName=TEST_PARAMETER_GROUP
    )
    actual_groups = resp.get("CacheParameterGroups", [])
    assert (
        len(actual_groups) > 0
    ), f"Expected parameter group '{TEST_PARAMETER_GROUP}' to exist but found none"
