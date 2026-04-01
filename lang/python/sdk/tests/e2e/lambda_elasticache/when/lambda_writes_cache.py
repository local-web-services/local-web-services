"""When: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation')
def lambda_writes_cache(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        lws_session.client("elasticache").describe_cache_clusters(CacheClusterId=TEST_CLUSTER)
    except Exception:  # noqa: BLE001
        world["error"] = RuntimeError("Cluster does not exist")
        return
    # Act
    if lws_session.capacity("elasticache").is_exhausted():
        world["error"] = RuntimeError("No key slot is available")
        return
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
