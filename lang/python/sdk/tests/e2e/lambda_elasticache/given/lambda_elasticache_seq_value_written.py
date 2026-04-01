"""Given: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation')
def lambda_elasticache_seq_value_written(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
    # Assert
    world["invocation_id"] = invocation_id
