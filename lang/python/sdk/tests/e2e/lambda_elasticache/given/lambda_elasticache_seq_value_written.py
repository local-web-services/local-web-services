"""Given: the Lambda function has written a value to the ElastiCache cluster during invocation"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given("the Lambda function has written a value to the ElastiCache cluster during invocation")
def lambda_elasticache_seq_value_written(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
    # Assert
    world["invocation_id"] = invocation_id
