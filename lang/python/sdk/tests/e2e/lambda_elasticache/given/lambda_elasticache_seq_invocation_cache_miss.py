"""Given: the "lambda" "function" invocation fails because all cache entries have been evicted"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('the "lambda" "function" invocation fails because all cache entries have been evicted')
def lambda_elasticache_seq_invocation_cache_miss(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
    # Assert
    world["invocation_id"] = invocation_id
