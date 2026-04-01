"""When: an "memorydb" "ACL" is associated with a "memorydb" "cluster" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_ACL, TEST_CLUSTER


@when('an "memorydb" "ACL" is associated with a "memorydb" "cluster"')
def associate_acl_with_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("memorydb").update_cluster(
            ClusterName=TEST_CLUSTER, ACLName=TEST_ACL
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
