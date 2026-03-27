"""When: the Lambda invocation fails because all cache entries have been evicted"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda invocation fails because all cache entries have been evicted")
def invocation_fails_cache_miss(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
