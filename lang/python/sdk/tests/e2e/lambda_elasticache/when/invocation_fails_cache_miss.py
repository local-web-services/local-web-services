"""When: the "lambda" "function" invocation fails because all cache entries have been evicted"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" invocation fails because all cache entries have been evicted')
def invocation_fails_cache_miss(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    if world.get("cached_entry_exists", False):
        world["error"] = RuntimeError('A "CACHED" entry exists in the cluster')
        return
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
