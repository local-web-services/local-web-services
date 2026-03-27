"""Given: the Lambda invocation has read an existing cache entry and completed successfully"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given("the Lambda invocation has read an existing cache entry and completed successfully")
def lambda_elasticache_seq_invocation_read_succeeded(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
    # Assert
    world["invocation_id"] = invocation_id
