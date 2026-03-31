"""Given: the "lambda" "function" is invoked"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('the "lambda" "function" is invoked')
def lambda_elasticache_seq_function_invoked(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "IN_PROGRESS")
    # Assert
    world["invocation_id"] = invocation_id
