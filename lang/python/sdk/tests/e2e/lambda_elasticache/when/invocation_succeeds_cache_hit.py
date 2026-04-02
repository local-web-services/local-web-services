"""When: the "lambda" "function" invocation reads an existing cache entry and completes successfully"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" invocation reads an existing cache entry and completes successfully')
def invocation_succeeds_cache_hit(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    if not world.get("cached_entry_exists", False):
        world["error"] = RuntimeError('No "CACHED" entry exists in the cluster')
        return
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
